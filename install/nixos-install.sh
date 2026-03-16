#!/usr/bin/env bash

set -euo pipefail
trap 'echo "Error on line $LINENO"' ERR

# 颜色定义
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

readonly MOUNT_POINT="/mnt"

# 打印带颜色的消息
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# 询问是/否，默认否
prompt_yes_no() {
    local prompt=$1
    local default=${2:-no}
    read -p "${prompt} (yes/no, Default: ${default}) " response
    echo "${response:-$default}"
}

# 获取用户输入，可设置默认值
get_user_input() {
    local prompt=$1
    local default=$2
    read -p "${prompt} (Default: ${default}): " value
    echo "${value:-$default}"
}

# 获取数字输入（仅正整数）
get_number_input() {
    local prompt=$1
    local default=$2
    local value
    while true; do
        read -p "${prompt} (Default: ${default}): " value
        value="${value:-$default}"
        if [[ "$value" =~ ^[0-9]+$ ]]; then
            echo "$value"
            break
        else
            print_message "$RED" "请输入有效的正整数。"
        fi
    done
}

# 列出可用磁盘
list_disks() {
    print_message "$CYAN" "检测到的磁盘："
    lsblk -d -o NAME,TYPE,SIZE,MODEL | grep -E "^[a-z]+[0-9]*\s+disk" || {
        print_message "$RED" "未检测到任何磁盘。"
        exit 1
    }
}

# 选择磁盘
select_disk() {
    local disk
    while true; do
        read -p "请输入要分区的磁盘设备（例如 /dev/nvme0n1 或 /dev/sda）: " disk
        if [[ -b "$disk" ]]; then
            echo "$disk"
            break
        else
            print_message "$RED" "无效的设备，请重新输入。"
        fi
    done
}

# 分区功能
partition_disk() {
    print_message "$GREEN" "=== 分区硬盘 ==="

    # 检查 /mnt 是否已挂载，若已挂载则提示风险
    if mountpoint -q "$MOUNT_POINT"; then
        print_message "$YELLOW" "警告：${MOUNT_POINT} 当前已挂载。继续操作可能导致数据损坏。"
        local proceed=$(prompt_yes_no "是否强制继续？" "no")
        if [[ "$proceed" != "yes" ]]; then
            print_message "$RED" "取消分区操作。"
            return
        fi
        # 尝试卸载已有挂载
        umount -R "$MOUNT_POINT" 2>/dev/null || true
    fi

    # 列出磁盘并选择
    list_disks
    local disk_device
    disk_device=$(select_disk)

    print_message "$YELLOW" "警告：此操作将清除 ${disk_device} 上的所有数据！"
    local confirm=$(prompt_yes_no "确定要继续吗？" "no")
    if [[ "$confirm" != "yes" ]]; then
        print_message "$RED" "取消分区。"
        return
    fi

    # 获取 EFI 分区大小（MB）
    local efi_size_mb
    efi_size_mb=$(get_number_input "请输入 EFI 分区大小 (MB)" 1024)

    # 询问是否创建 swap 子卷
    local create_swap
    create_swap=$(prompt_yes_no "是否创建 swap 子卷？" "no")
    local swap_size_gb=16   # 默认 16GB
    if [[ "$create_swap" == "yes" ]]; then
        swap_size_gb=$(get_number_input "请输入 swap 文件大小 (GB)" 16)
    fi

    # 确定分区设备名后缀（NVMe 等需要加 p）
    local dev_name
    dev_name=$(basename "$disk_device")
    local part_prefix=""
    if [[ "${dev_name: -1}" =~ [0-9] ]]; then
        part_prefix="p"
    fi
    local efi_part="${disk_device}${part_prefix}1"
    local root_part="${disk_device}${part_prefix}2"

    # 分区
    print_message "$GREEN" "正在分区 ${disk_device}..."
    printf "label: gpt\n,${efi_size_mb}M,U\n,,L\n" | sfdisk "$disk_device"

    # 格式化
    print_message "$GREEN" "格式化 EFI 分区为 vfat..."
    mkfs.vfat -F 32 "$efi_part"

    print_message "$GREEN" "格式化根分区为 btrfs..."
    mkfs.btrfs -f "$root_part"

    # 创建子卷
    print_message "$GREEN" "创建 btrfs 子卷..."
    mount "$root_part" "$MOUNT_POINT"

    local subvolumes=("@" "@home" "@nix" "@log" "@.snapshots")
    if [[ "$create_swap" == "yes" ]]; then
        subvolumes+=("@swap")
    fi

    for subvol in "${subvolumes[@]}"; do
        btrfs subvolume create "$MOUNT_POINT/$subvol"
    done
    umount "$MOUNT_POINT"

    # 检测 SSD 优化
    local ssd_option="nossd"
    local rotational
    rotational=$(cat "/sys/block/$(basename "$disk_device")/queue/rotational" 2>/dev/null || echo "1")
    if [[ "$rotational" == "0" ]]; then
        ssd_option="ssd"
    fi

    local mount_opts="rw,relatime,compress=zstd:3,$ssd_option,discard=async,space_cache=v2"

    # 挂载子卷
    print_message "$GREEN" "挂载子卷..."
    mount -o "$mount_opts,subvol=/@" "$root_part" "$MOUNT_POINT"

    # 挂载其他子卷
    mkdir -p "$MOUNT_POINT"/{home,nix,var/log,.snapshots,boot}
    mount -o "$mount_opts,subvol=/@home" "$root_part" "$MOUNT_POINT/home"
    mount -o "$mount_opts,subvol=/@nix" "$root_part" "$MOUNT_POINT/nix"
    mount -o "$mount_opts,subvol=/@log" "$root_part" "$MOUNT_POINT/var/log"
    mount -o "$mount_opts,subvol=/@.snapshots" "$root_part" "$MOUNT_POINT/.snapshots"
    mount -o "rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=utf8,shortname=mixed,utf8,errors=remount-ro" "$efi_part" "$MOUNT_POINT/boot"

    if [[ "$create_swap" == "yes" ]]; then
        mkdir -p "$MOUNT_POINT/swap"
        mount -o "subvol=/@swap" "$root_part" "$MOUNT_POINT/swap"
        print_message "$GREEN" "创建 swap 文件 (${swap_size_gb}G)..."
        btrfs filesystem mkswapfile --size "${swap_size_gb}G" --uuid clear "$MOUNT_POINT/swap/swapfile"
    fi

    print_message "$GREEN" "分区和挂载完成。当前挂载情况："
    lsblk "$disk_device"
    df -h "$MOUNT_POINT"
}

# 生成基础 NixOS 配置
generate_config() {
    print_message "$GREEN" "=== 生成基础 NixOS 配置 ==="
    if ! mountpoint -q "$MOUNT_POINT"; then
        print_message "$RED" "错误：${MOUNT_POINT} 未挂载，请先运行分区。"
        return 1
    fi
    print_message "$CYAN" "执行：nixos-generate-config --root $MOUNT_POINT"
    nixos-generate-config --root "$MOUNT_POINT"
    print_message "$GREEN" "配置已生成：$MOUNT_POINT/etc/nixos/"
    print_message "$YELLOW" "您可以手动编辑 hardware-configuration.nix 和 configuration.nix。"
}

# 执行安装
install_system() {
    print_message "$GREEN" "=== 执行 NixOS 安装 ==="
    if [[ ! -f "$MOUNT_POINT/etc/nixos/configuration.nix" ]]; then
        print_message "$RED" "错误：未找到 $MOUNT_POINT/etc/nixos/configuration.nix"
        print_message "$YELLOW" "请先生成配置或手动创建。"
        return 1
    fi
    print_message "$YELLOW" "即将运行 nixos-install，期间可能需要设置 root 密码。"
    local confirm=$(prompt_yes_no "确定开始安装？" "no")
    if [[ "$confirm" != "yes" ]]; then
        print_message "$RED" "取消安装。"
        return
    fi
    nixos-install --option substituters "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    print_message "$GREEN" "安装完成！您可以重启进入新系统。"
}

# 主菜单
show_menu() {
    while true; do
        echo
        print_message "$CYAN" "========== NixOS 安装助手 =========="
        echo "1. 分区硬盘"
        echo "2. 生成基础 NixOS 配置 (nixos-generate-config)"
        echo "3. 执行安装 (nixos-install)"
        echo "0. 退出"
        read -p "请选择功能 [0-3]: " choice
        case "$choice" in
            1) partition_disk ;;
            2) generate_config ;;
            3) install_system ;;
            0) print_message "$GREEN" "再见。"; exit 0 ;;
            *) print_message "$RED" "无效选择，请重新输入。" ;;
        esac
    done
}

# 检查 root 权限
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_message "$RED" "此脚本必须以 root 身份运行。"
        exit 1
    fi
}

# 检查必需命令
check_requirements() {
    local required_commands=("sfdisk" "mkfs.vfat" "mkfs.btrfs" "btrfs" "nixos-generate-config" "nixos-install" "lsblk")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            print_message "$RED" "必需命令 '$cmd' 未找到，请安装相应软件包。"
            exit 1
        fi
    done
}

main() {
    check_root
    check_requirements
    print_message "$GREEN" "欢迎使用 NixOS 安装脚本"
    show_menu
}

main "$@"
