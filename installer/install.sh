#!/usr/bin/env bash

set -e

echo "========== Copy Hardware Config =========="
sudo cp /etc/nixos/hardware-configuration.nix ../outputs/x86_64-linux/nixos/

echo "========== Generate Secrets Flake =========="
cp ./modules/secrets-flake.nix ../secrets/flake.nix
cd ../secrets
if [ ! -d .git ]; then
    git init
fi
git add --all

echo "========== Rebuild System =========="
cd ../
git add --all -- ':!secrets'
nixos-rebuild switch --flake .#nixos \
  --option  substituters "https://mirror.sjtu.edu.cn/nix-channels/store https://mirrors.ustc.edu.cn/nix-channels/store https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
