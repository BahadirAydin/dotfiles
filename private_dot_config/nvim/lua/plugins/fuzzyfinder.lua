return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope Old Files" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Telescope LSP Diagnostics" },
			{ "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Telescope Command History" },
			{ "<leader>fs", "<cmd>Telescope spell_suggest<cr>", desc = "Telescope Spell Suggest" },
			{
				"<leader>fi",
				function()
					require("telescope.builtin").symbols({ source = { "gitmoji" } })
				end,
				desc = "Find Gitmoji",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules/", "build/", "target/", "vendor/", "out/" },
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
					preview = {
						filesize_limit = 0.1, -- MB
					},
					vimgrep_arguments = vim.fn.executable("rg") == 1 and {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					} or nil,
					layout_config = {
						vertical = {
							width = 0.8,
						},
					},
				},
				pickers = {
					help_tags = {
						layout_strategy = "vertical",
					},
					diagnostics = {
						layout_strategy = "vertical",
					},
					lsp_references = {
						layout_strategy = "vertical",
					},
					lsp_incoming_calls = {
						layout_strategy = "vertical",
					},
					find_files = {
						layout_strategy = "vertical",
						find_command = vim.fn.executable("rg") == 1 and { "rg", "--files", "--hidden", "-g", "!.git" }
							or nil,
					},
					buffers = {
						layout_strategy = "vertical",
						sort_lastused = true,
						ignore_current_buffer = true,
					},
					oldfiles = {
						layout_strategy = "vertical",
						sort_lastused = true,
					},
				},
			})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons", optional = true },
		cmd = { "FzfLua" },
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find All Files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume Search" },
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
			hls = {
				border = "FloatBorder",
				preview_border = "FloatBorder",
				help_border = "FloatBorder",
				title = "TelescopeTitle",
				preview_title = "TelescopePreviewTitle",
			},
			winopts = {
				preview = {
					layout = "vertical",
				},
			},
		},
	},
}
