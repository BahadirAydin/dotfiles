return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				ui_select = true,
				formatters = {
					file = {
						filename_first = true,
					},
				},
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Snacks: Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Snacks: Live Grep",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Snacks: Resume Search",
			},
			{
				"<leader>b",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Snacks: Buffers",
			},
			{
				"<leader>fo",
				function()
					Snacks.picker.recent()
				end,
				desc = "Snacks: Old Files",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Snacks: Command History",
			},
			{
				"<leader>fs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Snacks: Git Status",
			},
			{
				"<leader>fd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Snacks: Diagnostics Workspace",
			},
			{
				"<leader>fl",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "Snacks: LSP Document Symbols",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.git_log({
						confirm = function(picker, item)
							picker:close()
							if item and item.commit then
								local sha = item.commit
								vim.cmd("DiffviewOpen " .. sha .. "~.." .. sha)
							end
						end,
					})
				end,
				desc = "Diffview: review commit",
			},
		},
	},
}
