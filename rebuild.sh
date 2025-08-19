#!/usr/bin/env bash

# Check for two arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <hardware> <edition>"
    exit 1
fi

HARDWARE=$1
EDITION=$2

# Run nixos-rebuild for the specified flake, edition, and hardware
sudo nixos-rebuild switch --flake .#$HARDWARE-$EDITION