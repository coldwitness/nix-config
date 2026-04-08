#!/usr/bin/env bash

set -e

echo "========== Copy Hardware Config =========="
# 生成默认配置文件
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix ../../outputs/hosts/x86_64-linux/nixos/

echo "========== Generate Secrets Flake =========="
cp ./modules/secrets-flake.nix ../../secrets/flake.nix
cd ../../secrets
if [ ! -d .git ]; then
    git init
fi
git add --all

echo "========== Rebuild System =========="
cd ../
git add --all -- ':!secrets'
nix-shell -p nh --run "nh os switch . --ask --max-jobs 1"
