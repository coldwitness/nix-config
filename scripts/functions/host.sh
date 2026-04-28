#!/usr/bin/env bash

# =============================================================================
# 主机检测与选择函数 (应用 NixOS 配置模式使用)
# 依赖: 调用方需已 set -e 并定义 REPO_ROOT
# =============================================================================

# -----------------------------------------------------------------------------
# 检测 outputs/nixos/ 下的可用主机
# 返回格式: "主机名|主机路径" (每行一个)
# 条件: 目录存在且包含 opts.nix
# -----------------------------------------------------------------------------
detect_hosts() {
    local hosts=()
    local nixos_dir="$REPO_ROOT/outputs/nixos"

    if [ ! -d "$nixos_dir" ]; then
        return 1
    fi

    for host_dir in "$nixos_dir"/*/; do
        [ -d "$host_dir" ] || continue
        if [ -f "$host_dir/opts.nix" ]; then
            local name path
            name=$(basename "$host_dir")
            path=$(realpath "$host_dir")
            hosts+=("$name|$path")
        fi
    done

    if [ ${#hosts[@]} -eq 0 ]; then
        return 1
    fi

    printf '%s\n' "${hosts[@]}"
}

# -----------------------------------------------------------------------------
# 交互式选择目标主机
# 设置全局变量 HOST_NAME / HOST_PATH
# -----------------------------------------------------------------------------
select_host() {
    local hosts
    mapfile -t hosts < <(detect_hosts) || die "No host directories found in outputs/nixos/"
    local host_count=${#hosts[@]}

    while true; do
        echo "Available hosts:"
        local i=1
        for host in "${hosts[@]}"; do
            printf "  [%d] %s\n" "$i" "${host%|*}"
            i=$((i + 1))
        done
        read -r -p "Select host [1-$host_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$host_count" ]; then
            local selected="${hosts[$((selection - 1))]}"
            HOST_NAME="${selected%|*}"
            HOST_PATH="${selected#*|}"
            echo "Selected host: $HOST_NAME"
            return 0
        else
            echo "Invalid selection, please enter a number between 1 and $host_count"
        fi
    done
}
