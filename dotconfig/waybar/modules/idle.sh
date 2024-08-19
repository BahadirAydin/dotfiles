#!/bin/bash

if pgrep hypridle > /dev/null; then
    killall hypridle
else
    hyprctl dispatch exec hypridle
fi
