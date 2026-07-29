-- Walk up from the cwd looking for any of `markers`, stopping at $HOME.
local function find_up(markers)
	local dir = vim.fn.getcwd()
	local home = vim.uv.os_homedir()
	while dir and dir ~= "" do
		for _, m in ipairs(markers) do
			if vim.fn.filereadable(dir .. "/" .. m) == 1 then
				return dir
			end
		end
		if dir == home then
			break
		end
		local parent = vim.fn.fnamemodify(dir, ":h")
		if parent == dir then
			break
		end
		dir = parent
	end
end

-- Ninja is preferred on every platform; without it fall back to the make
-- flavour that matches the toolchain (MinGW on Windows).
local function generator()
	if vim.fn.executable("ninja") == 1 then
		return "Ninja"
	end
	return vim.fn.has("win32") == 1 and "MinGW Makefiles" or "Unix Makefiles"
end

local function generate_options()
	local options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }
	-- A preset pins its own generator and cmake rejects -G on top of
	-- --preset, so only choose one for preset-less projects.
	if not find_up({ "CMakePresets.json", "CMakeUserPresets.json" }) then
		vim.list_extend(options, { "-G", generator() })
	end
	return options
end

-- cmake-tools drives its own progress spinner, but its notification module is
-- hard-wired to `require("notify")` (rcarriga/nvim-notify), which this config
-- replaced with snacks.notifier. That require fails, every cmake-tools
-- notification is silently dropped, this fixes the issue
local function notify(msg, level, opts)
	Snacks.notifier.notify(msg, level, vim.tbl_extend("keep", opts, { id = "cmake-build", title = "CMake" }))
end

local function build()
	-- A function `opts` is re-evaluated on every render pass, and the frame of
	-- `Snacks.util.spinner()` comes from the clock, so this animates without a
	-- timer of its own.
	notify("Building…", "info", {
		timeout = false,
		opts = function(n)
			n.icon = Snacks.util.spinner()
		end,
	})

	-- Every early return in cmake.build() still invokes the callback, including
	-- a cancelled target/preset picker, so the spinner always gets replaced.
	require("cmake-tools").build({}, function(result)
		-- The executor pops the native quickfix window on failure before it
		-- reaches here, so close it either way.
		vim.cmd.cclose()
		if result:is_ok() then
			notify("Build succeeded", "info", { icon = "", timeout = 1000 })
			require("trouble").close("qflist")
		else
			notify("Build failed", "error", { icon = "", timeout = 1000 })
			require("trouble").open({ mode = "qflist", focus = true })
		end
	end)
end

return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
		cond = function()
			return find_up({ "CMakeLists.txt", "CMakePresets.json", "CMakeUserPresets.json" }) ~= nil
		end,
		opts = {
			cmake_generate_options = generate_options(),
			cmake_regenerate_on_save = true,
			cmake_use_preset = true,
			cmake_executor = {
				name = "quickfix",
				opts = { show = "only_on_error" },
			},
			cmake_compile_commands_options = {
				action = "copy",
			},
			cmake_dap_configuration = {
				type = "codelldb",
				request = "launch",
				stopOnEntry = false,
				terminal = "integrated",
			},
			cmake_build_directory = function()
				local osys = require("cmake-tools.osys")
				if osys.iswin32 then
					return "out\\${variant:buildType}"
				end
				return "out/${variant:buildType}"
			end,
		},
		keys = {
			{ "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake: Generate" },
			{ "<leader>cb", build, desc = "CMake: Build" },
			{ "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean" },
			{ "<leader>ct", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMake: Select configure preset." },
			{ "<leader>cs", "<cmd>CMakeSelectBuildPreset<cr>", desc = "CMake: Select build preset." },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
			{ "<leader>cd", "<cmd>CMakeDebug<cr>", desc = "CMake: Debug" },
			{ "<leader>cl", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake: Select launch target." },
			{ "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake: Install" },
		},
	},
}
