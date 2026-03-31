#!/usr/bin/env bash

set -e

DISK=""

# 加载函数模块
source "$(dirname "$0")/functions/disk.sh"

echo "========== Select Install Disk =========="

select_disk

# 检测并卸载已挂载的分区
unmount_disk "$DISK"

echo "========== Partition Disk =========="
# 使用 disko 进行分区, 格式化, 挂载
sudo nix run 'git+https://gitee.com/nix-config/disko.git?rev=e92033d8960a363b963cce697aa3ff091fe42a8a&shallow=1' \
  --extra-experimental-features "nix-command flakes" \
  --option  substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" \
  -- \
  --argstr disk $DISK \
  --yes-wipe-all-disks \
  --mode destroy,format,mount ./modules/disk-config.nix

echo "========== Generate Config =========="
# 生成默认配置文件
sudo nixos-generate-config --root /mnt
# 复制额外配置文件
sudo cp ./modules/extra-configuration.nix /mnt/etc/nixos/extra-configuration.nix
# 引用额外配置文件
sudo sed -i 's|./hardware-configuration.nix|./hardware-configuration.nix\n      ./extra-configuration.nix|' /mnt/etc/nixos/configuration.nix

echo "========== Install System =========="
# 执行安装命令
sudo nixos-install --root /mnt \
  --option  substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
