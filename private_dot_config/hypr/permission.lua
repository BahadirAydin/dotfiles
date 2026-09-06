--# PERMISSIONS ##
-- https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
--
-- Gates apps that talk to Wayland capture protocols directly, instead of going
-- through xdg-desktop-portal. Anything not listed here falls back to its
-- default: screencopy, cursorpos and input-capture ask, keyboard allows.
--
-- Requires hyprland-guiutils to draw the prompts.

hl.config({
	ecosystem = {
		enforce_permissions = true,
	},
})

-- Screenshots: the Print / ALT+Print binds.
hl.permission({ binary = "/usr/bin/grim", type = "screencopy", mode = "allow" })

-- Colour picker.
hl.permission({ binary = "/usr/bin/hyprpicker", type = "screencopy", mode = "allow" })

-- The portal itself is just another app under this system. Without this rule,
-- every screen share (Zoom, Firefox) would prompt.
hl.permission({ binary = "/usr/lib/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })

-- Only needed if hyprlock.conf goes back to `path = screenshot`, but harmless
-- now and saves a puzzling prompt on the lock screen later.
hl.permission({ binary = "/usr/bin/hyprlock", type = "screencopy", mode = "allow" })
