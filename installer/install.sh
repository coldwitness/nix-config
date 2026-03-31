#!/usr/bin/env bash

set -e

echo "========== 1. 生成默认配置文件 =========="
sudo nixos-generate-config
echo "✓ 配置文件生成完成"
echo ""

echo "========== 2. 复制硬件配置文件 =========="
sudo cp /etc/nixos/hardware-configuration.nix ../outputs/x86_64-linux/nixos/
echo "✓ 硬件配置文件复制完成"
echo ""

echo "========== 3. 构造 secrets-flake =========="
cp ./secrets-flake.nix ../secrets/flake.nix
cd ../secrets
if [ ! -d .git ]; then
    git init
fi
git add --all
echo "✓ secrets-flake 构造完成"
echo ""

echo "========== 4. 执行系统重建 =========="
cd ../
git add --all
nix-shell -p nh --run "nh os switch . --ask"
echo "✓ 系统重建完成"
