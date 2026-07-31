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
			cmake_compile_commands_options = {
				action = "copy",
			},
			-- :CMakeDebug builds the selected launch target, asks for one if none
			-- is set, and hands nvim-dap the program, cwd, args and env itself.
			-- This table is merged over that with "force", so it deliberately
			-- carries no `name`: cmake-tools names the session after the target.
			-- Adapters are defined in dap.lua.
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
			{ "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
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
