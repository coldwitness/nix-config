#!/usr/bin/env bash

# =============================================================================
# 用户检测与选择函数 (应用 Home Manager 配置模式使用)
# 依赖: 调用方需已 set -e 并定义 REPO_ROOT
# =============================================================================

# -----------------------------------------------------------------------------
# 检测 outputs/home/ 下的可用用户
# 返回格式: "用户名|用户路径" (每行一个)
# 条件: 目录存在且包含 opts.nix
# -----------------------------------------------------------------------------
detect_users() {
    local users=()
    local home_dir="$REPO_ROOT/outputs/home"

    if [ ! -d "$home_dir" ]; then
        return 1
    fi

    for user_dir in "$home_dir"/*/; do
        [ -d "$user_dir" ] || continue
        if [ -f "$user_dir/opts.nix" ]; then
            local name path
            name=$(basename "$user_dir")
            path=$(realpath "$user_dir")
            users+=("$name|$path")
        fi
    done

    if [ ${#users[@]} -eq 0 ]; then
        return 1
    fi

    printf '%s\n' "${users[@]}"
}

# -----------------------------------------------------------------------------
# 交互式选择目标用户
# 设置全局变量 USER_NAME / USER_PATH
# 注意: 不再需要选择架构 (架构已在 opts.nix 的 system 字段中定义)
# -----------------------------------------------------------------------------
select_user() {
    local users
    mapfile -t users < <(detect_users) || die "No user directories found in outputs/home/"
    local user_count=${#users[@]}

    while true; do
        echo "Available users:"
        local i=1
        for user in "${users[@]}"; do
            printf "  [%d] %s\n" "$i" "${user%|*}"
            i=$((i + 1))
        done
        read -r -p "Select user [1-$user_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$user_count" ]; then
            local selected="${users[$((selection - 1))]}"
            USER_NAME="${selected%|*}"
            USER_PATH="${selected#*|}"
            echo "Selected user: $USER_NAME"
            return 0
        else
            echo "Invalid selection, please enter a number between 1 and $user_count"
        fi
    done
}
