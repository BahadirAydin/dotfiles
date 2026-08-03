return {
	{
		"stevearc/overseer.nvim",
		opts = {
			component_aliases = {
				default = {
					"on_exit_set_status",
					"on_complete_notify",
					{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
					{ "open_output", on_start = "never", on_complete = "failure", focus = true },
				},
			},
		},
		keys = {
			{ "<leader>rr", "<cmd>OverseerRun<CR>", desc = "Run task" },
			{ "<leader>rc", "<cmd>OverseerShell<CR>", desc = "Run shell command" },
			{ "<leader>rt", "<cmd>OverseerToggle<CR>", desc = "Toggle task list" },
			{ "<leader>ra", "<cmd>OverseerTaskAction<CR>", desc = "Task action" },
		},
	},
}
