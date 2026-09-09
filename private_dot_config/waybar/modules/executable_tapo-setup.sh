#!/bin/sh
# Install the separate Rust helper; optionally import controller config.json.
set -eu
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-tapo"
build_dir="${CARGO_TARGET_DIR:-$cache_dir/build}"
binary="$HOME/.local/bin/waybar-tapo"
if [ -n "${WAYBAR_TAPO_SOURCE:-}" ]; then
    source_dir=$WAYBAR_TAPO_SOURCE
else
    source_dir="$cache_dir/source"
    if [ -d "$source_dir/.git" ]; then
        git -C "$source_dir" pull --ff-only
    else
        mkdir -p "$cache_dir"
        git clone --filter=blob:none --single-branch \
            git@github.com:BahadirAydin/waybar-tapo.git "$source_dir"
    fi
fi
cargo build --release --locked --manifest-path "$source_dir/Cargo.toml" --target-dir "$build_dir"
mkdir -p "$(dirname -- "$binary")"
# Replace atomically so a polling Waybar never runs a partially copied binary.
install -m 755 "$build_dir/release/waybar-tapo" "$binary.new"
mv -f "$binary.new" "$binary"
if [ "$#" -gt 0 ]; then
    "$binary" --import-config "$1"
else
    printf 'Using local configuration: %s/waybar/tapo.json\n' "${XDG_CONFIG_HOME:-$HOME/.config}"
fi
