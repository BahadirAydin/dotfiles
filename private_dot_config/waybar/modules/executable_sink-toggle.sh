#!/bin/bash

scarlett="alsa_output.usb-Focusrite_Scarlett_2i2_4th_Gen_S2Y2UV65632DD7-00.pro-output-0"
current=$(pactl info | awk -F': ' '/Default Sink/ {print $2}')

if [ "$current" = "$scarlett" ]; then
    icon=""
    name="Scarlett 2i2"
else
    icon=""
    name="Built-in Audio"
fi

echo "{\"text\":\"$icon\",\"tooltip\":\"$name\"}"
