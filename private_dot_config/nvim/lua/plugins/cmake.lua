return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
		cond = function()
			local markers = { "CMakeLists.txt", "CMakePresets.json", "CMakeUserPresets.json" }
			local dir = vim.fn.getcwd()
			local home = vim.loop.os_homedir()
			while dir and dir ~= "" do
				for _, m in ipairs(markers) do
					if vim.fn.filereadable(dir .. "/" .. m) == 1 then
						return true
					end
				end
				if dir == home then break end
				local parent = vim.fn.fnamemodify(dir, ":h")
				if parent == dir then break end
				dir = parent
			end
			return false
		end,
		opts = {
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_regenerate_on_save = true,
			cmake_use_preset = true,
			cmake_compile_commands_options = {
				action = "copy",
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
			{ "<leader>cg", "<cmd>CMakeGenerate -G Ninja<cr>", desc = "CMake: Generate" },
			{ "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
			{ "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean" },
			{ "<leader>ct", "<cmd>CMakeSelectConfigurePreset<cr>", desc = "CMake: Select configure preset." },
			{ "<leader>cs", "<cmd>CMakeSelectBuildPreset<cr>", desc = "CMake: Select build preset." },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
			{ "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake: Install" },
		},
	},
}
