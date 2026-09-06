#!/bin/sh
set -eu
# $./volume.sh up | down | mute

SINK="@DEFAULT_AUDIO_SINK@"
STEP="5%"
LIMIT="2.0"   # 200%, matching the old --allow-boost --set-limit 200

audio_icon_high="audio-volume-high-symbolic"
audio_icon_medium="audio-volume-medium-symbolic"
audio_icon_low="audio-volume-low-symbolic"
mute_icon="audio-volume-muted-blocking-symbolic"

# "Volume: 0.55" or "Volume: 0.55 [MUTED]"
get_volume() {
    wpctl get-volume "$SINK" | awk '{ printf "%d", $2 * 100 }'
}

is_mute() {
    wpctl get-volume "$SINK" | grep -q MUTED
}

send_notification() {
    vol=$(get_volume)
    if [ "$vol" -ge 70 ]; then
        audio_icon="$audio_icon_high"
    elif [ "$vol" -ge 50 ]; then
        audio_icon="$audio_icon_medium"
    else
        audio_icon="$audio_icon_low"
    fi
    dunstify -i "$audio_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Volume" -h int:value:"$vol"
}

case $1 in
    up)
        wpctl set-volume -l "$LIMIT" "$SINK" "$STEP+"
        send_notification
        ;;
    down)
        wpctl set-volume "$SINK" "$STEP-"
        send_notification
        ;;
    mute)
        wpctl set-mute "$SINK" toggle
        if is_mute; then
            dunstify -i "$mute_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Mute"
        else
            send_notification
        fi
        ;;
esac
