return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				enabled = true,
				change_to_vcs_root = true,
				sections = {
					{
						section = "terminal",
						enabled = vim.fn.executable("chafa") == 1
							and vim.fn.filereadable(vim.fn.expand("~/.config/colorful-valley.png")) == 1,
						cmd = {
							"chafa",
							vim.fn.expand("~/.config/colorful-valley.png"),
							"--format",
							"symbols",
							"--symbols",
							"vhalf",
							"--size",
							"60x17",
							"--stretch",
						},
						height = 16,
						padding = 1,
					},
					{ section = "header" },
					{
						pane = 2,
						{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
						{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
						{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					},
					{ section = "startup" },
				},
				preset = {
					header = vim.fn.executable("figlet") == 1 and vim.fn
						.system({ "figlet", os.date("%A") })
						:gsub("\n+$", "") or nil,
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{ icon = "󰆼 ", key = "o", desc = "File Explorer", action = ":Oil" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{
							icon = " ",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
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
