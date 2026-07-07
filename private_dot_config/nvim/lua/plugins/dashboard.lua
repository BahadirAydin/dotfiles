return {
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				enabled = true,
				change_to_vcs_root = true,
				sections = {
					{
						section = "terminal",
						enabled = vim.fn.executable("chafa") == 1 and vim.fn.filereadable(
							vim.fn.expand("~/.local/share/wallpapers/colorful-valley.png")
						) == 1,
						cmd = {
							"chafa",
							vim.fn.expand("~/.local/share/wallpapers/colorful-valley.png"),
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
							action = ":lua Snacks.picker.grep()",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.picker.recent()",
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
		},
	},
}
