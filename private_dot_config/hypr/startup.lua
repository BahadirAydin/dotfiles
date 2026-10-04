--# STARTUP APPLICATIONS ##

-- exec-once=[workspace special silent] thunderbird

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
	hl.exec_cmd("systemctl --user start hyprpaper.service")
	hl.exec_cmd("systemctl --user start waybar.service")
	hl.exec_cmd("systemctl --user start dunst.service")
	hl.exec_cmd("systemctl --user start hypridle.service")
	hl.exec_cmd("systemctl --user start hyprsunset.service")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("copyq --start-server")
end)
