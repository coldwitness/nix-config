#!/usr/bin/env bash

set -e

source functions/user.sh

echo "========== Select User =========="
select_user
echo "Selected user: $USER_NAME"

echo "========== Select Platform =========="
select_platform
echo "Selected platform: $PLATFORM"

echo "========== Generate Secrets Flake =========="
cd ../../secrets
if [ ! -f flake.nix ]; then
    cp ../scripts/installer/modules/secrets-flake.nix ./flake.nix
    git init
    git add --all
fi

echo "========== Apply Home Manager Config =========="
cd ../
git add --all -- ':!secrets'
nix-shell -p nh --run "nh home switch .#$USER_NAME-$PLATFORM --ask"
