return {
	-- CMake integration
	{
		"Civitasv/cmake-tools.nvim",
		opts = {},
		keys = {
			{ "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "CMake: Generate" },
			{ "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
			{ "<leader>cc", "<cmd>CMakeClean<cr>", desc = "CMake: Clean" },
			{ "<leader>ct", "<cmd>CMakeSelectBuildType<cr>", desc = "CMake: Select build type" },
			{ "<leader>cs", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "CMake: Select target" },
			{ "<leader>cr", "<cmd>CMakeRun<cr>", desc = "CMake: Run" },
			{ "<leader>ci", "<cmd>CMakeInstall<cr>", desc = "CMake: Install" },
		},
	},
}
