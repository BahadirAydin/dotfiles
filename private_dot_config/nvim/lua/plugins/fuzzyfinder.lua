return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
		cmd = { "FzfLua" },
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "FzfLua: Files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "FzfLua: Live Grep" },
			{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "FzfLua: Resume Search" },
			{ "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "FzfLua: Buffers" },
			{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "FzfLua: Old Files" },
			{ "<leader>fh", "<cmd>FzfLua command_history<cr>", desc = "FzfLua: Command History" },
			{ "<leader>fs", "<cmd>FzfLua git_status<cr>", desc = "FzfLua: Git Status" },
			{ "<leader>fd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "FzfLua: Diagnostics Workspace" },
			{ "<leader>fl", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "FzfLua: LSP Document Symbols" },
			{
				"<leader>fc",
				function()
					require("fzf-lua").git_commits({
						actions = {
							["default"] = function(selected)
								local sha = selected[1]:match("^([0-9a-f]+)")
								if sha then
									vim.cmd("DiffviewOpen " .. sha .. "~.." .. sha)
								end
							end,
						},
					})
				end,
				desc = "Diffview: review commit",
			},
		},
		opts = {
			oldfiles = {
				include_current_session = true,
			},
			previewers = {
				builtin = {
					syntax_limit_b = 1024 * 100, -- 100KB
				},
			},
		},
	},
}
