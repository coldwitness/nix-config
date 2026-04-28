#!/usr/bin/env bash

# =============================================================================
# 磁盘检测与选择函数 (LiveCD 模式使用)
# 依赖: 调用方需已 set -e 并定义 REPO_ROOT / MODULES_DIR
# =============================================================================

# -----------------------------------------------------------------------------
# 检测可用磁盘设备 (通过 lsblk 列出所有磁盘)
# 返回格式: "/dev/sda 238.5G (disk)"
# -----------------------------------------------------------------------------
detect_disks() {
    local disks=()
    while IFS= read -r line; do
        disks+=("$line")
    done < <(lsblk -nd -o NAME,SIZE,TYPE 2>/dev/null | grep 'disk$' | awk '{print "/dev/" $1 " " $2 " (" $3 ")"}')
    printf '%s\n' "${disks[@]}"
}

# -----------------------------------------------------------------------------
# 交互式选择安装目标磁盘
# 设置全局变量 DISK
# -----------------------------------------------------------------------------
select_disk() {
    local disks
    mapfile -t disks < <(detect_disks)
    local disk_count=${#disks[@]}

    if [ "$disk_count" -eq 0 ]; then
        die "No disk devices found"
    fi

    while true; do
        echo "Available disks:"
        local i=1
        for disk in "${disks[@]}"; do
            printf "  [%d] %s\n" "$i" "$disk"
            i=$((i + 1))
        done
        read -r -p "Select disk number [1-$disk_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$disk_count" ]; then
            local disk_dev
            disk_dev=$(echo "${disks[$((selection - 1))]}" | awk '{print $1}')
            if [ -b "$disk_dev" ]; then
                DISK="$disk_dev"
                echo "Selected disk: $DISK"
                return 0
            else
                echo "Error: Selected disk $disk_dev is not available"
            fi
        else
            echo "Invalid selection, please enter a number between 1 and $disk_count"
        fi
    done
}

# -----------------------------------------------------------------------------
# 检测并卸载目标磁盘上已挂载的分区
# 参数: $1 — 磁盘设备路径 (如 /dev/sda)
# -----------------------------------------------------------------------------
unmount_disk() {
    local disk="$1"
    local mounted

    mounted=$(lsblk -no MOUNTPOINT "$disk"* 2>/dev/null | grep -v '^$' | sort -u)

    if [ -n "$mounted" ]; then
        echo "Warning: Disk $disk has mounted partitions, unmounting..."
        for mp in $mounted; do
            if [ "$mp" != "[SWAP]" ] && [ -d "$mp" ]; then
                echo "Unmounting $mp..."
                sudo umount -l "$mp" 2>/dev/null || true
            fi
        done
    fi
}
