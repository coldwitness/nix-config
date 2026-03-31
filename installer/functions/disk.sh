#!/usr/bin/env bash

# 检测可用磁盘设备
detect_disks() {
    local disks=()
    while IFS= read -r line; do
        disks+=("$line")
    done < <(lsblk -nd -o NAME,SIZE,TYPE | grep 'disk$' | awk '{print "/dev/" $1 " " $2 " (" $3 ")"}')
    printf '%s\n' "${disks[@]}"
}

# 选择安装磁盘
select_disk() {
    local disks
    mapfile -t disks < <(detect_disks)
    local disk_count=${#disks[@]}

    if [ "$disk_count" -eq 0 ]; then
        echo "Error: No disk devices found"
        exit 1
    fi

    while true; do
        echo "Available disks:"
        local i=1
        for disk in "${disks[@]}"; do
            echo "  [$i] $disk"
            i=$((i + 1))
        done
        read -p "Select disk number [1-$disk_count]: " selection

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

# 检测并卸载已挂载的磁盘分区
unmount_disk() {
    local disk="$1"
    local mounted

    mounted=$(lsblk -no MOUNTPOINT "$disk"* 2>/dev/null | grep -v '^$' | grep -v '^$' | sort -u)

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
