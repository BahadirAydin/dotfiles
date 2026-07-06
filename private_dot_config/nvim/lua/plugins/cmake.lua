return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
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
			{ "<leader>ct", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake: Select build type" },
			{ "<leader>cs", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake: Select target" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
			{ "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake: Install" },
		},
	},
}
