return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			indent = {
				enabled = true,
				exclude = {
					filetypes = {
						"help",
						"markdown",
						"text",
						"dashboard",
						"lazy",
						"mason",
						"checkhealth",
						"man",
						"lspinfo",
						"TelescopePrompt",
						"TelescopeResults",
						"git",
						"gitcommit",
						"",
					},
				},
			},
			zen = {
				enabled = true,
				win = { backdrop = { transparent = false } },
			},
			-- Disables treesitter, LSP, indent, etc. on files larger than 1.5MB to prevent freezes
			bigfile = { enabled = true },
			-- Renders the file before plugins load when running `nvim file.txt` for faster perceived startup
			quickfile = { enabled = true },
			-- LSP-integrated file rename: notifies LSP servers (workspace/willRenameFiles) so imports update across the project
			rename = { enabled = true },
			-- LazyGit in a float with auto-configured colorscheme and nvim-remote edit integration
			lazygit = { enabled = true },
			-- Open current file/branch/commit on GitHub/GitLab/Bitbucket in the browser
			gitbrowse = { enabled = true },
			-- Replaces nvim-notify; noice routes its notifications here automatically
			notifier = { enabled = true, timeout = 3000 },
		},
		keys = {
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "LazyGit",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "x" },
			},
			{
				"<leader>nn",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
		},
		init = function()
			vim.api.nvim_create_user_command("ZenMode", function()
				require("snacks").zen()
			end, { desc = "Toggle Zen Mode" })
		end,
	},
}
