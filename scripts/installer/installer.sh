#!/usr/bin/env bash

set -e

source functions/platform.sh

echo "========== Select Platform =========="
select_platform

echo "========== Copy Hardware Config =========="
# 生成默认配置文件
sudo nixos-generate-config
sudo cp /etc/nixos/hardware-configuration.nix ../../outputs/hosts/${PLATFORM}/${PLATFORM}/

echo "========== Generate Secrets Flake =========="
cd ../../secrets
if [ ! -f flake.nix ]; then
    cp ../scripts/installer/modules/secrets-flake.nix ./flake.nix
    git init
    git add --all
fi

echo "========== Rebuild System =========="
cd ../
git add --all -- ':!secrets'
nix-shell -p nh --run "nh os switch .#${PLATFORM} --ask --max-jobs 1"
