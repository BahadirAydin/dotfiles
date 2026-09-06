--# MONITOR CONFIGURATION ##

local LAPTOP = "eDP-1"
local EXTERNAL = "HDMI-A-2"

local function docked()
	hl.monitor({ output = EXTERNAL, mode = "3440x1440@49.99", position = "0x0", scale = "1" })
	hl.monitor({ output = LAPTOP, mode = "1920x1080@60", position = "3440x0", scale = "1" })
end

local function undocked()
	hl.monitor({ output = LAPTOP, mode = "1920x1080@60", position = "0x0", scale = "1" })
end

local function apply()
	if hl.get_monitor(EXTERNAL) then
		docked()
	else
		undocked()
	end
end

-- Run on load, so `hyprctl reload` re-applies the right layout too.
apply()

-- React to docking. Keyed off the event's own Monitor so we never race
-- the monitor list. Other outputs are ignored.
hl.on("monitor.added", function(m)
	if m.name == EXTERNAL then
		docked()
	end
end)

hl.on("monitor.removed", function(m)
	if m.name == EXTERNAL then
		undocked()
	end
end)

hl.monitor({ output = "HDMI-A-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = EXTERNAL, default = true })
hl.workspace_rule({ workspace = "10", monitor = LAPTOP, default = true })
