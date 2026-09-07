#!/bin/sh
set -eu
# Reports / toggles the hyprsunset blue-light filter.
#
#   sunset.sh          -> one line of JSON for Waybar
#   sunset.sh toggle   -> flip filter on/off, then refresh the module
#
# hyprsunset owns the schedule (see ~/.config/hypr/hyprsunset.conf); this only
# reads the live temperature and forces it one way or the other. A toggle holds
# until the next profile boundary, when the schedule takes back over.
#
# "Off" is an explicit 6500K rather than `hyprctl hyprsunset identity`, because
# identity leaves the reported temperature untouched -- there would be no way to
# read the state back afterwards. See the note in hyprsunset.conf.
#
# One glyph in both states, deliberately: the colour carries the state, the way
# the workspace buttons do. Off is dim, on is gold.
#
# Refreshed on a slow interval, and immediately on SIGRTMIN+9 which the toggle
# below raises.

NIGHT_TEMP=3400
NEUTRAL=6500
ICON='' # fa-adjust, a half-filled disc; expanded by printf %b below

# Current temperature in kelvin, or the neutral value when hyprsunset is not
# running. Only trusts hyprctl on a clean exit: its connection errors are prose
# containing the socket path, and the digits in that path parse as a plausible
# temperature.
get_temp() {
    if out=$(hyprctl hyprsunset temperature 2>/dev/null); then
        temp=$(printf '%s' "$out" | tr -d '[:space:]')
        case "$temp" in
            *[!0-9]* | "") ;;
            *) printf '%s' "$temp"; return ;;
        esac
    fi
    printf '%s' "$NEUTRAL"
}

if [ "${1:-}" = toggle ]; then
    if [ "$(get_temp)" -lt "$NEUTRAL" ]; then
        hyprctl hyprsunset temperature "$NEUTRAL" >/dev/null
    else
        hyprctl hyprsunset temperature "$NIGHT_TEMP" >/dev/null
    fi
    pkill -RTMIN+9 waybar 2>/dev/null || true
    exit 0
fi

temp=$(get_temp)
if [ "$temp" -lt "$NEUTRAL" ]; then
    printf '{"text":"%b","tooltip":"Blue light filter  %sK","class":"on"}\n' "$ICON" "$temp"
else
    printf '{"text":"%b","tooltip":"Blue light filter off","class":"off"}\n' "$ICON"
fi
