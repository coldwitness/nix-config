#!/usr/bin/env bash

set -e

echo "========== 复制硬件配置文件 =========="
sudo cp /etc/nixos/hardware-configuration.nix ../outputs/x86_64-linux/nixos/

echo "========== 构造 secrets-flake =========="
cp ./modules/secrets-flake.nix ../secrets/flake.nix
cd ../secrets
if [ ! -d .git ]; then
    git init
fi
git add --all

echo "========== 执行系统重建 =========="
cd ../
git add --all
nix-shell -p nh --run "nh os switch . --ask"
