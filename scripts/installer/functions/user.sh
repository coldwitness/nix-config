#!/usr/bin/env bash

USER_NAME=""
USER_PATH=""
PLATFORM=""

detect_users() {
    local users=()
    for user_dir in ../../outputs/users/*/; do
        if [ -d "$user_dir" ] && [ "$(basename "$user_dir")" != "root" ] && [ -f "$user_dir/default.nix" ] && [ -f "$user_dir/opts.nix" ]; then
            local name path
            name=$(basename "$user_dir")
            path=$(realpath "$user_dir")
            users+=("$name|$path")
        fi
    done
    printf '%s\n' "${users[@]}"
}

detect_platforms() {
    local platforms=()
    for platform_dir in ../../outputs/hosts/*/; do
        if [ -d "$platform_dir" ]; then
            platforms+=("$(basename "$platform_dir")")
        fi
    done
    printf '%s\n' "${platforms[@]}"
}

select_user() {
    local users
    mapfile -t users < <(detect_users)
    local user_count=${#users[@]}

    if [ "$user_count" -eq 0 ]; then
        echo "Error: No user directories found in outputs/users/"
        exit 1
    fi

    while true; do
        echo "Available users:"
        local i=1
        for user in "${users[@]}"; do
            echo "  [$i] ${user%|*}"
            i=$((i + 1))
        done
        read -p "Select user [1-$user_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$user_count" ]; then
            local selected="${users[$((selection - 1))]}"
            USER_NAME="${selected%|*}"
            USER_PATH="${selected#*|}"
            echo "Selected user: $USER_NAME"
            return 0
        else
            echo "Invalid selection"
        fi
    done
}

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
