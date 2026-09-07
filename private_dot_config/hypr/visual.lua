hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 5,
	bezier = "default",
	style = "fade",
})

hl.config({
	decoration = {
		rounding = 10,
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
		},
	},
	group = {
		col = {
			border_active = "rgba(E9B949cc)",
			border_inactive = "rgba(FFFFFF12)",
		},
		groupbar = {
			col = {
				active = "rgba(E9B949cc)",
			},
			rounding = 10,
		},
	},
})

-- The bar is translucent, so it needs the compositor to blur what is behind it.
hl.layer_rule({
	match = { namespace = "waybar" },
	blur = true,
	ignore_alpha = 0.05,
})
