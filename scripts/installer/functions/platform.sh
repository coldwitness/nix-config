#!/usr/bin/env bash

# 检测可用的系统架构
detect_platforms() {
    local platforms=()
    for dir in ../../outputs/hosts/*/; do
        if [ -d "$dir" ] && [ -f "$dir/default.nix" ]; then
            local name
            name=$(basename "$dir")
            platforms+=("$name")
        fi
    done
    printf '%s\n' "${platforms[@]}"
}

# 选择系统架构
select_platform() {
    local platforms
    mapfile -t platforms < <(detect_platforms)
    local platform_count=${#platforms[@]}

    if [ "$platform_count" -eq 0 ]; then
        echo "Error: No platform directories found in outputs/hosts/"
        exit 1
    fi

    while true; do
        echo "Available platforms:"
        local i=1
        for platform in "${platforms[@]}"; do
            echo "  [$i] $platform"
            i=$((i + 1))
        done
        read -p "Select platform [1-$platform_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$platform_count" ]; then
            PLATFORM="${platforms[$((selection - 1))]}"
            echo "Selected platform: $PLATFORM"
            return 0
        else
            echo "Invalid selection"
        fi
    done
}
