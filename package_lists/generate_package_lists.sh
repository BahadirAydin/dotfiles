#!/bin/bash
set -euo pipefail

echo "Generating package lists in $(pwd)..."

# PACMAN
if command -v pacman &> /dev/null; then
    echo "Generating pacman lists..."
    pacman -Qqen > pacman.txt        # Official repo packages
    pacman -Qqem > pacman-aur.txt    # AUR packages
fi

# CARGO
if command -v cargo &> /dev/null; then
    echo "Generating cargo.txt..."
    cargo install --list | awk '/^[^ ]+ v[0-9]/ {print $1}' > cargo.txt
fi

# NPM
if command -v npm &>/dev/null; then
    echo "Generating npm.txt..."

    if command -v fnm &>/dev/null; then
        eval "$(fnm env --shell bash)"
    fi

    npm ls --global --depth=0 --json |
        jq -r '.dependencies | keys[]' |
        grep -vxE 'npm|corepack' >npm.txt
fi

echo "Done."
