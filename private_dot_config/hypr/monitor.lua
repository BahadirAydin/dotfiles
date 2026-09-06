--# MONITOR CONFIGURATION ##

local LAPTOP = "eDP-1"
local EXTERNAL = "HDMI-A-2"

-- logind is configured HandleLidSwitch=suspend / HandleLidSwitchDocked=ignore,
-- so with the external monitor attached a closed lid does nothing at all and
-- the panel keeps rendering behind it. Read the ACPI state at load time; the
-- switch binds below cover it from then on.
local function lid_closed()
	local f = io.open("/proc/acpi/button/lid/LID/state", "r")
	if not f then
		return false
	end
	local state = f:read("*a")
	f:close()
	return state:match("closed") ~= nil
end

local function laptop_docked_position()
	hl.monitor({
		output = LAPTOP,
		mode = "1920x1080@60",
		position = "3440x0",
		scale = "1",
		disabled = false,
	})
end

local function docked()
	hl.monitor({ output = EXTERNAL, mode = "3440x1440@49.99", position = "0x0", scale = "1" })
	if lid_closed() then
		hl.monitor({ output = LAPTOP, disabled = true })
	else
		laptop_docked_position()
	end
end

local function undocked()
	hl.monitor({
		output = LAPTOP,
		mode = "1920x1080@60",
		position = "0x0",
		scale = "1",
		disabled = false,
	})
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

-- SW_LID: "on" is shut, "off" is open. Driven off the switch direction rather
-- than re-reading /proc, so there is no race with the ACPI state update.
-- Undocked the panel is the only screen, so it is never disabled there --
-- logind suspends instead.
local function set_laptop_panel(enabled)
	if not hl.get_monitor(EXTERNAL) then
		return
	end
	if enabled then
		laptop_docked_position()
	else
		hl.monitor({ output = LAPTOP, disabled = true })
	end
end

hl.bind("switch:on:Lid Switch", function()
	set_laptop_panel(false)
end, { locked = true, description = "Lid shut: drop the laptop panel while docked" })

hl.bind("switch:off:Lid Switch", function()
	set_laptop_panel(true)
end, { locked = true, description = "Lid opened: restore the laptop panel" })

hl.monitor({ output = "HDMI-A-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = EXTERNAL, default = true })
hl.workspace_rule({ workspace = "10", monitor = LAPTOP, default = true })
