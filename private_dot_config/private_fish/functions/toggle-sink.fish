function toggle-sink
    set -l scarlett "alsa_output.usb-Focusrite_Scarlett_2i2_4th_Gen_S2Y2UV65632DD7-00.pro-output-0"
    set -l builtin "alsa_output.pci-0000_00_1f.3.analog-stereo"

    set -l current (pactl info | string match -r 'Default Sink: .*' | string replace 'Default Sink: ' '')

    set -l target
    set -l target_name

    if test "$current" = "$scarlett"
        set target $builtin
        set target_name "Built-in Audio"
    else
        set target $scarlett
        set target_name "Scarlett 2i2"
    end

    if not pactl list sinks short | grep -q "$target"
        dunstify -u critical "Audio Toggle" "$target_name is unavailable."
        return 1
    end

    pactl set-default-sink "$target"

    pactl list sink-inputs short | awk '{print $1}' | while read -l id
        if test -n "$id"
            pactl move-sink-input "$id" "$target"
        end
    end

    dunstify "Audio Toggle" "Switched to $target_name"
end
