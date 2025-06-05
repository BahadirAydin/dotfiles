return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
		opts = {
			cmake_build_directory = function()
				local osys = require("cmake-tools.osys")
				if osys.iswin32 then
					return "out\\${variant:buildType}"
				end
				return "out/${variant:buildType}"
			end,
			cmake_notifications = {
				runner = { enabled = false },
				executor = { enabled = false },
			},
		},
		keys = {
			{ "<leader>cg", "<cmd>CMakeGenerate Ninja<cr>", desc = "CMake: Generate" },
			{ "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
			{ "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean" },
			{ "<leader>ct", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake: Select build type" },
			{ "<leader>cs", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake: Select target" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
			{ "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake: Install" },
		},
	},
}
