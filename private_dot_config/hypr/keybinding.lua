--## BINDS ### 

--# Applications ##
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + N", hl.dsp.exec_cmd(terminal .. " " .. file_manager))
-- bind = $mod SHIFT, N, exec, $terminal $file_manager_terminal
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" -t png"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grim -o \"$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')\" -t png"))
hl.bind(mod .. " + A", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -show-icons"))
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill rofimoji ||  rofimoji"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("pkill rofi || rofi -show power-menu -modi power-menu:rofi-power-menu"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("firefox --new-window music.youtube.com"))

--# Audio ##
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/dunst/volume.sh up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/dunst/volume.sh down"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/dunst/volume.sh mute"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute"), { repeating = true })
hl.bind(mod .. " + SHIFT + X", hl.dsp.exec_cmd("fish -c toggle-sink"))
--# Brightness ##
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/dunst/brightness.sh up"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/dunst/brightness.sh down"), { repeating = true })

--# Window Management ##
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

--## Groups ###
hl.bind(mod .. " + G", hl.dsp.group.toggle())
hl.bind(mod .. " + Tab", hl.dsp.group.next())

--# Workspace Management ##

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special(""))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))

hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

--# Resize Mode ##
hl.bind(mod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()

    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

    hl.bind("escape", hl.dsp.submap("reset"))
end)
