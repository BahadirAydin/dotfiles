--## BINDS ###

--# Applications ##
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal), { description = "Open a terminal" })
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser), { description = "Open the browser" })
hl.bind(mod .. " + N", hl.dsp.exec_cmd(terminal .. " " .. file_manager), { description = "Open the file manager" })
-- bind = $mod SHIFT, N, exec, $terminal $file_manager_terminal

-- Screenshots go to ~/Pictures and onto the clipboard.
-- Region select; slurp exits non-zero when cancelled, so bail before grim runs.
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		'g="$(slurp)" || exit 0; f="$HOME/Pictures/$(date +%Y%m%d_%Hh%Mm%Ss)_grim.png"; grim -g "$g" -t png "$f" && wl-copy --type image/png < "$f"'
	),
	{ description = "Screenshot a region" }
)
hl.bind(
	"ALT + Print",
	hl.dsp.exec_cmd(
		'f="$HOME/Pictures/$(date +%Y%m%d_%Hh%Mm%Ss)_grim.png"; grim -o "$(hyprctl monitors | awk \'/Monitor/{mon=$2} /focused: yes/{print mon}\')" -t png "$f" && wl-copy --type image/png < "$f"'
	),
	{ description = "Screenshot the focused monitor" }
)

hl.bind(
	mod .. " + A",
	hl.dsp.exec_cmd("pkill -x rofi || rofi -show drun -show-icons"),
	{ description = "App launcher" }
)
hl.bind(mod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill -x rofi || rofimoji"), { description = "Emoji picker" })
hl.bind(
	mod .. " + L",
	hl.dsp.exec_cmd("pkill -x rofi || rofi -show power-menu -modi power-menu:rofi-power-menu"),
	{ description = "Power menu" }
)
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock the screen" })
hl.bind(
	mod .. " + T",
	hl.dsp.exec_cmd("~/.config/waybar/modules/sunset.sh toggle"),
	{ description = "Toggle the blue light filter" }
)
hl.bind(
	mod .. " + M",
	hl.dsp.exec_cmd("firefox --new-window music.youtube.com"),
	{ description = "Open YouTube Music" }
)

--# Audio ##
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/dunst/volume.sh up"),
	{ repeating = true, description = "Raise volume" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/dunst/volume.sh down"),
	{ repeating = true, description = "Lower volume" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("~/.config/dunst/volume.sh mute"),
	{ repeating = true, description = "Toggle output mute" }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true, description = "Toggle microphone mute" }
)
hl.bind(mod .. " + SHIFT + X", hl.dsp.exec_cmd("fish -c toggle-sink"), { description = "Switch audio output device" })

--# Brightness ##
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.config/dunst/brightness.sh up"),
	{ repeating = true, description = "Raise screen brightness" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.config/dunst/brightness.sh down"),
	{ repeating = true, description = "Lower screen brightness" }
)

--# Window Management ##
hl.bind(mod .. " + C", hl.dsp.window.close(), { description = "Close the active window" })
hl.bind(mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(
	mod .. " + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ description = "Toggle fullscreen" }
)
hl.bind(mod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudotiling" })
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"), { description = "Toggle the dwindle split direction" })

hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })

--## Groups ###
hl.bind(mod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(mod .. " + Tab", hl.dsp.group.next(), { description = "Next window in group" })

--# Workspace Management ##

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special(""), { description = "Toggle the scratchpad" })

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- Workspaces 1-10 on the number row; 10 lives on the 0 key.
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Focus workspace " .. i })
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "Move window to workspace " .. i }
	)
end

hl.bind(
	mod .. " + SHIFT + S",
	hl.dsp.window.move({ workspace = "special" }),
	{ description = "Move window to the scratchpad" }
)

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus left" })
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus up" })
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus down" })

--# Resize Mode ##
hl.bind(mod .. " + R", hl.dsp.submap("resize"), { description = "Enter the resize submap" })

hl.define_submap("resize", function()
	hl.bind(
		"right",
		hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
		{ repeating = true, description = "Grow horizontally" }
	)
	hl.bind(
		"left",
		hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
		{ repeating = true, description = "Shrink horizontally" }
	)
	hl.bind(
		"up",
		hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
		{ repeating = true, description = "Shrink vertically" }
	)
	hl.bind(
		"down",
		hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
		{ repeating = true, description = "Grow vertically" }
	)

	hl.bind("escape", hl.dsp.submap("reset"), { description = "Leave the resize submap" })
end)
