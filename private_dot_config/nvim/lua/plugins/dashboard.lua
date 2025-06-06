return {
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				change_to_vcs_root = true,
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{
							desc = "󰊳 Update",
							group = "@property",
							action = "Lazy update",
							key = "u",
						},
						{
							desc = " Mason",
							group = "@property",
							action = "Mason",
							key = "m",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Grep",
							group = "Label",
							action = "Telescope live_grep",
							key = "g",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "File Explorer",
							group = "Label",
							action = "Oil",
							key = "o",
						},
					},
				},
			})
		end,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
			},
		},
	},
}
