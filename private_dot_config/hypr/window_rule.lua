hl.window_rule({
	match = {
		class = "^org\\.pulseaudio\\.pavucontrol$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^blueman-manager$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^zoom$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^org\\.qbittorrent\\.qBittorrent$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^anki$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = ".*",
	},
	idle_inhibit = "fullscreen",
})

-- Apps asking to maximize themselves fight the tiling layout; ignore them.
hl.window_rule({
	name = "suppress-maximize",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Firefox picture-in-picture: keep it floating and visible across workspaces.
hl.window_rule({
	name = "firefox-pip",
	match = {
		class = "^firefox$",
		title = "^Picture-in-Picture$",
	},
	float = true,
	pin = true,
	size = { 640, 360 },
})

hl.window_rule({
	match = {
		class = "^firefox$",
		title = "^Opening .*$",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^firefox$",
		title = "^Save As$",
	},
	float = true,
})
