--# TOUCHPAD GESTURES ##
-- https://wiki.hypr.land/Configuring/Core/Binds/Gestures/

-- 3 fingers horizontal: 1:1 animated workspace swipe.
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- 4 fingers down: toggle output mute, via the same script the
-- XF86AudioMute key uses, so the dunst OSD stays consistent.
hl.gesture({
	fingers = 4,
	direction = "down",
	action = function()
		hl.exec_cmd("~/.config/dunst/volume.sh mute")
	end,
})
