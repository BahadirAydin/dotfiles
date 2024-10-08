#!/bin/sh
set -eu
# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

# icons
audio_icon_high="audio-volume-high-symbolic"
audio_icon_medium="audio-volume-medium-symbolic"
audio_icon_low="audio-volume-low-symbolic"
mute_icon="audio-volume-muted-blocking-symbolic"

# output
# use the following option for pulseaudio
#output_name="pulse"
# use the following option for alsa
output_name="pulse"



get_volume () {
    pamixer --get-volume
}

is_mute() {
    pamixer --get-mute
}

send_notification () {
    # Send the notification
    dunstify -i "$audio_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Volume" -h int:value:"$(get_volume)"
}

if [ "$(get_volume)" -ge 70 ]; then
    audio_icon="$audio_icon_high"
elif [ "$(get_volume)" -ge 50 ]; then
    audio_icon="$audio_icon_medium"
else
    audio_icon="$audio_icon_low"
fi

case $1 in
    up)
    pamixer --allow-boost --set-limit 200 -ui 5
	send_notification
	;;
    down)
    pamixer --allow-boost --set-limit 200 -ud 5
	send_notification
	;;
    mute)
    pamixer --toggle-mute
	if is_mute ; then
	    dunstify -i "$mute_icon" -t 1600 -h string:x-dunst-stack-tag:volume -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac


