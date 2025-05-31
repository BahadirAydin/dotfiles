#!/bin/sh
set -eu
# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

# icon
brightness_icon_high="display-brightness-high-symbolic"
brightness_icon_medium="display-brightness-medium-symbolic"
brightness_icon_low="display-brightness-low-symbolic"

get_brightness () {
    b=$(brightnessctl i | grep -oP '(?<=\().*?(?=%)')
}

send_notification () {
	# Send the notification
    dunstify -i "$brightnessicon" -t 1600 -h string:x-dunst-stack-tag:brightness -u normal "Brightness" -h int:value:"$b"
}
brightness_check () {
    if [ "$b" -ge 70 ]; then
        brightnessicon="$brightness_icon_high"
    elif [ "$b" -ge 50 ]; then
        brightnessicon="$brightness_icon_medium"
    elif [ "$b" -ge 10 ]; then
        brightnessicon="$brightness_icon_low"
    	changevalue="5"
    else
        brightnessicon="$brightness_icon_low"
    fi
}
case $1 in
    down)
        brightnessctl set 10%- > /dev/null
        get_brightness
        brightness_check
        send_notification
        ;;
    up)
        brightnessctl set +10% > /dev/null
        get_brightness
        brightness_check
        send_notification
        ;;
esac

