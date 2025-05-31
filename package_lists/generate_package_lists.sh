#!/bin/bash
set -euo pipefail

echo "Generating package lists in $(pwd)..."

# PACMAN
if command -v pacman &> /dev/null; then
    echo "Generating pacman.txt..."
    pacman -Qqe > pacman.txt
fi

# CARGO
if command -v cargo &> /dev/null; then
    echo "Generating cargo.txt..."
    cargo install --list | awk '/^[^ ]+ v[0-9]/ {print $1}' > cargo.txt
fi

# NPM
if command -v npm &> /dev/null; then
    echo "Generating npm.txt..."
    npm -g list --depth=0 | awk -F '── ' '/──/ {print $2}' > npm.txt
fi

# FONT CONFIG
if command -v fc-list &> /dev/null; then
    echo "Generating fc-list.txt..."
    fc-list : family | sort -u > fc-list.txt
fi

echo "Done."
