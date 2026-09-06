#!/bin/bash

if pgrep hypridle > /dev/null; then
    killall hypridle
else
    hyprctl dispatch 'hl.dsp.exec_cmd("hypridle")'
fi
