#!/bin/bash
# Reports the current default sink for Waybar. Deliberately knows nothing about
# specific devices: the icon is chosen from the sink's bus (usb = external
# interface, anything else = built-in), so the Focusrite's node name only ever
# has to be spelled out in toggle-sink.fish.
#
# Refreshed on a slow interval, and immediately on SIGRTMIN+8 which
# toggle-sink.fish raises after switching.

default=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')
desc=$(pactl -f json list sinks 2>/dev/null | python3 -c '
import json, sys
want = sys.argv[1]
for s in json.load(sys.stdin):
    if s["name"] == want:
        print(s["description"])
        break
' "$default")
[ -z "$desc" ] && desc="$default"

case "$default" in
    alsa_output.usb-*) icon="\uf025" ;;
    *)                 icon="\uf028" ;;
esac

printf '{"text":"%b","tooltip":"%s"}\n' "$icon" "$desc"
