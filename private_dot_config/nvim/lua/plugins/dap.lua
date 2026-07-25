-- Debugging: C/C++ and Rust through codelldb, Python through debugpy.
--
-- Stepping is done with the arrow keys, but only while a session is running:
--   <Up>    continue        <Down>   step over
--   <Right> step into       <Left>   step out
--
local prefix = "<leader>u"

local is_win = vim.fn.has("win32") == 1
local mason = vim.fn.stdpath("data") .. "/mason/packages"
local codelldb = mason .. "/codelldb/extension/adapter/codelldb" .. (is_win and ".exe" or "")
local debugpy = mason .. "/debugpy/venv/" .. (is_win and "Scripts/python.exe" or "bin/python")

local function key(suffix)
	return prefix .. suffix
end

-- Install the debug adapters through mason the first time nvim-dap is loaded.
local function ensure_installed(packages)
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return
	end
	local missing = vim.tbl_filter(function(name)
		return not registry.is_installed(name)
	end, packages)
	-- refreshing the registry goes out to the network, so only pay for it on the
	-- one session where something is actually missing
	if #missing == 0 then
		return
	end
	registry.refresh(function()
		for _, name in ipairs(missing) do
			local found, pkg = pcall(registry.get_package, name)
			if found and not pkg:is_installed() then
				vim.notify("dap: installing " .. name, vim.log.levels.INFO)
				pkg:install()
			end
		end
	end)
end

-- Breakpoint signs and the highlight for the line the debugger is stopped on.
local function set_signs()
	local groups = {
		DapBreakpoint = "#f38ba8",
		DapBreakpointCondition = "#fab387",
		DapLogPoint = "#89b4fa",
		DapBreakpointRejected = "#6c7086",
		DapStopped = "#a6e3a1",
	}
	for group, color in pairs(groups) do
		vim.api.nvim_set_hl(0, group, { fg = color })
	end
	-- cursorlineopt is "number", so the stopped line is the only full-line
	-- highlight and stays clearly visible.
	vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#4c4327" })

	vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "◇", texthl = "DapBreakpointCondition" })
	vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected" })
	vim.fn.sign_define("DapStopped", {
		text = "▶",
		texthl = "DapStopped",
		numhl = "DapStopped",
		linehl = "DapStoppedLine",
	})
end

-- Arrow keys are only mapped while a session is alive, so they keep their
-- normal cursor behaviour the rest of the time.
local stepping = {
	["<Up>"] = { "continue", "Debug: continue" },
	["<Down>"] = { "step_over", "Debug: step over" },
	["<Right>"] = { "step_into", "Debug: step into" },
	["<Left>"] = { "step_out", "Debug: step out" },
}

local function toggle_stepping_keys(enable)
	for lhs, map in pairs(stepping) do
		if enable then
			vim.keymap.set("n", lhs, function()
				require("dap")[map[1]]()
			end, { desc = map[2] })
		else
			pcall(vim.keymap.del, "n", lhs)
		end
	end
end

-- This prompt only comes up outside cmake projects, since :CMakeDebug resolves
-- its own target, so it just has to land in the directory cargo or a plain
-- build writes to and let file completion do the rest. Deriving a binary name
-- from the project directory is not worth it: it guesses wrong the moment the
-- target is named differently (A-hello-cmake/ builds hello_cmake.exe).
local dirs = { "target/debug", "out/Debug", "build" }

local function guess_program()
	local cwd = vim.fn.getcwd()
	for _, dir in ipairs(dirs) do
		if vim.fn.isdirectory(cwd .. "/" .. dir) == 1 then
			return ("%s/%s/"):format(cwd, dir)
		end
	end
	return cwd .. "/"
end

local function program()
	local path = vim.fn.input({ prompt = "Path to executable: ", default = guess_program(), completion = "file" })
	if path == "" then
		return require("dap").ABORT
	end
	return vim.fn.expand(path)
end

local function args()
	return vim.split(vim.fn.input({ prompt = "Arguments: " }), " ", { trimempty = true })
end

-- Teach lldb about Rust's std types (Vec, String, HashMap, ...).
local function rust_pretty_printers()
	if vim.fn.executable("rustc") == 0 then
		return {}
	end
	local sysroot = vim.fn.trim(vim.fn.system({ "rustc", "--print", "sysroot" }))
	local commands_file = sysroot .. "/lib/rustlib/etc/lldb_commands"
	local commands = vim.fn.filereadable(commands_file) == 1 and vim.fn.readfile(commands_file) or {}
	table.insert(commands, 1, ("command script import '%s/lib/rustlib/etc/lldb_lookup.py'"):format(sysroot))
	return commands
end

local function setup_adapters()
	local dap = require("dap")

	-- codelldb bundles its own lldb, reads the DWARF that gcc/MinGW emits and
	-- renders libstdc++ containers, so it covers gcc, clang and Rust from a
	-- single adapter with no dependency on the system toolchain.
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = codelldb,
			args = { "--port", "${port}" },
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = program,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Launch with arguments",
			type = "codelldb",
			request = "launch",
			program = program,
			args = args,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Attach to process",
			type = "codelldb",
			request = "attach",
			pid = function()
				return require("dap.utils").pick_process()
			end,
			cwd = "${workspaceFolder}",
		},
	}
	dap.configurations.c = dap.configurations.cpp

	dap.configurations.rust = {
		{
			name = "Launch",
			type = "codelldb",
			request = "launch",
			program = program,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
			initCommands = rust_pretty_printers,
		},
		{
			name = "Launch with arguments",
			type = "codelldb",
			request = "launch",
			program = program,
			args = args,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
			initCommands = rust_pretty_printers,
		},
	}
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"igorlfs/nvim-dap-view",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")

			ensure_installed({ "codelldb", "debugpy" })
			set_signs()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("UserDapHighlights", { clear = true }),
				callback = set_signs,
			})

			setup_adapters()

			-- Picks up an activated virtualenv on its own, falls back to
			-- mason's debugpy.
			require("dap-python").setup(debugpy)
			require("dap-python").test_runner = "pytest"

			for _, event in ipairs({ "event_terminated", "event_exited", "disconnect", "terminate" }) do
				dap.listeners.before[event]["dap-stepping-keys"] = function()
					toggle_stepping_keys(false)
				end
			end
			dap.listeners.after.event_initialized["dap-stepping-keys"] = function()
				toggle_stepping_keys(true)
			end
		end,
		keys = {
			{
				key("u"),
				function()
					require("dap").continue()
				end,
				desc = "Debug: start / continue",
			},
			{
				key("b"),
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: toggle breakpoint",
			},
			{
				key("B"),
				function()
					require("dap").set_breakpoint(vim.fn.input({ prompt = "Breakpoint condition: " }))
				end,
				desc = "Debug: conditional breakpoint",
			},
			{
				key("g"),
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input({ prompt = "Log message: " }))
				end,
				desc = "Debug: log point",
			},
			{
				key("x"),
				function()
					require("dap").clear_breakpoints()
				end,
				desc = "Debug: clear all breakpoints",
			},
			{
				key("c"),
				function()
					require("dap").run_to_cursor()
				end,
				desc = "Debug: run to cursor",
			},
			{
				key("p"),
				function()
					require("dap").pause()
				end,
				desc = "Debug: pause",
			},
			{
				key("r"),
				function()
					require("dap").restart()
				end,
				desc = "Debug: restart",
			},
			{
				key("l"),
				function()
					require("dap").run_last()
				end,
				desc = "Debug: run last configuration",
			},
			{
				key("q"),
				function()
					require("dap").terminate()
				end,
				desc = "Debug: terminate session",
			},
			{
				key("v"),
				function()
					require("dap-view").toggle()
				end,
				desc = "Debug: toggle UI",
			},
			{
				key("e"),
				function()
					require("dap-view").hover()
				end,
				desc = "Debug: evaluate under cursor",
			},
			{ key("w"), "<cmd>DapViewWatch<cr>", mode = { "n", "v" }, desc = "Debug: watch expression" },
			{
				key("t"),
				function()
					require("dap-view").jump_to_view("threads")
				end,
				desc = "Debug: threads / call stack",
			},
			{
				key("R"),
				function()
					require("dap-view").jump_to_view("repl")
				end,
				desc = "Debug: REPL",
			},
		},
	},
	{
		"igorlfs/nvim-dap-view",
		lazy = true,
		---@module "dap-view"
		---@type dapview.Config
		opts = {
			-- open the panel when a session starts, close it when it ends
			auto_toggle = true,
			winbar = {
				default_section = "scopes",
				sections = { "scopes", "watches", "threads", "breakpoints", "exceptions", "repl", "console" },
			},
			windows = {
				-- codelldb runs the debuggee in here
				terminal = { position = "right" },
			},
			virtual_text = {
				enabled = true,
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
	},
}
