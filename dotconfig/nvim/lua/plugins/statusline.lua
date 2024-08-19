return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},

		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "molokai",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "neo-tree" },
						winbar = { "neo-tree" },
						tabline = { "neo-tree" },
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" }, -- for example "os.date('%H:%M'))" can be added to show the current time
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = {}, -- 'progress'
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename", "filetype", "branch" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				-- tabline = {
				-- 	lualine_a = { "buffers" },
				-- 	lualine_b = { "branch" },
				-- 	lualine_c = {},
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = { "tabs" },
				-- },
				-- winbar = {
				-- lualine_a = {'buffers'},
				-- lualine_b = {},
				-- lualine_c = {},
				-- lualine_x = {},
				-- lualine_y = {},
				-- lualine_z = {}
				-- },
				-- inactive_winbar = {},
				extensions = {},
			})
		end,
		keys = {
			{ "<leader>1", "<cmd>LualineBuffersJump! 1<cr>", desc = "Jump to 1st buffer" },
			{ "<leader>2", "<cmd>LualineBuffersJump! 2<cr>", desc = "Jump to 2nd buffer" },
			{ "<leader>3", "<cmd>LualineBuffersJump! 3<cr>", desc = "Jump to 3rd buffer" },
			{ "<leader>4", "<cmd>LualineBuffersJump! 4<cr>", desc = "Jump to 4th buffer" },
			{ "<leader>5", "<cmd>LualineBuffersJump! 5<cr>", desc = "Jump to 5th buffer" },
			{ "<leader>6", "<cmd>LualineBuffersJump! 6<cr>", desc = "Jump to 6th buffer" },
			{ "<leader>7", "<cmd>LualineBuffersJump! 7<cr>", desc = "Jump to 7th buffer" },
			{ "<leader>8", "<cmd>LualineBuffersJump! 8<cr>", desc = "Jump to 8th buffer" },
			{ "<leader>9", "<cmd>LualineBuffersJump! 9<cr>", desc = "Jump to 9th buffer" },
			{ '<leader>"', "<cmd>LualineBuffersJump! $<cr>", desc = "Jump to last buffer" },
		},
	},
}
