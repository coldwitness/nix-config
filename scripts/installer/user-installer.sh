#!/usr/bin/env bash

set -e

source functions/user.sh

echo "========== Select User =========="
select_user
echo "Selected user: $USER_NAME"

echo "========== Select Platform =========="
select_platform
echo "Selected platform: $PLATFORM"

echo "========== Apply Home Manager Config =========="
cd ../../
git add --all
nix-shell -p nh --run "nh home switch .#$USER_NAME-$PLATFORM --ask --max-jobs 1"
