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
if command -v npm &> /dev/null; then
    echo "Generating npm.txt..."
    npm ls -g --depth=0 --parseable | xargs -n 1 basename | grep -v "lib" > npm.txt
fi

echo "Done."
