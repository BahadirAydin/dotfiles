mod = "SUPER"
terminal = "kitty"
browser = "firefox"
file_manager = "yazi"

require("env")
require("keybinding")
require("monitor")
require("startup")
require("window_rule")
require("visual")
require("gesture")

-- Below are default values

hl.config({
	general = {
		border_size = 4,
		gaps_in = 5,
		gaps_out = 10,
		col = {
			active_border = "rgba(D991FDFF)",
			inactive_border = "rgba(595959aa)",
		},
	},
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
	input = {
		kb_layout = "tr",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = false,
		},
	},
	-- https://wiki.hypr.land/Configuring/Basics/Variables/#gestures
	gestures = {
		workspace_swipe_touch = true,
	},
	layout = {
		-- Stop a lone window stretching the full 3440px on the ultrawide.
		-- Releases as soon as a second window opens. Tolerance stays at
		-- its default of 0.1.
		single_window_aspect_ratio = { 16, 9 },
	},
})
