mod = "SUPER"
terminal = "kitty"
browser = "firefox"
file_manager = "yazi"

-- Window border colours. ~/.config/themes holds one small Lua table per
-- theme, read straight from here -- change the name below to switch.
-- The literals in the fallback are Catppuccin Mocha, so a missing or broken
-- theme file leaves the borders looking right instead of taking the config down.
local THEME = "catppuccin-mocha"
package.path = os.getenv("HOME") .. "/.config/themes/?.lua;" .. package.path
local ok, t = pcall(require, THEME)
theme = ok and t or { accent = "rgba(CBA6F7cc)", inactive = "rgba(CDD6F412)" }

require("env")
require("keybinding")
require("monitor")
require("startup")
require("window_rule")
require("visual")
require("gesture")
require("permission")

-- Below are default values

hl.config({
	general = {
		border_size = 1,
		gaps_in = 5,
		gaps_out = 12,
		col = {
			active_border = theme.accent,
			inactive_border = theme.inactive,
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
