#!/usr/bin/env bash

HOST_NAME=""
HOST_PATH=""

detect_hosts() {
    local hosts=()
    for arch in ../../outputs/hosts/*/; do
        for host in "$arch"/*/; do
            if [ -d "$host" ] && [ -f "$host/default.nix" ]; then
                local name path
                name=$(basename "$host")
                path=$(realpath "$host")
                hosts+=("$name|$path")
            fi
        done
    done
    printf '%s\n' "${hosts[@]}"
}

select_host() {
    local hosts
    mapfile -t hosts < <(detect_hosts)
    local host_count=${#hosts[@]}

    if [ "$host_count" -eq 0 ]; then
        echo "Error: No host directories found in outputs/hosts/"
        exit 1
    fi

    while true; do
        echo "Available hosts:"
        local i=1
        for host in "${hosts[@]}"; do
            echo "  [$i] ${host%|*}"
            i=$((i + 1))
        done
        read -p "Select host [1-$host_count]: " selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "$host_count" ]; then
            local selected="${hosts[$((selection - 1))]}"
            HOST_NAME="${selected%|*}"
            HOST_PATH="${selected#*|}"
            echo "Selected host: $HOST_NAME"
            return 0
        else
            echo "Invalid selection"
        fi
    done
}
