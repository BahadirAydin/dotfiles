return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
						tabline = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff" },
					lualine_c = {
						"filename",
						"diagnostics",
						{
							"macro",
							fmt = function()
								local reg = vim.fn.reg_recording()
								if reg ~= "" then
									return "Recording @" .. reg
								end
								return nil
							end,
							color = { fg = "#ff9e64" },
							draw_empty = false,
						},
					}, -- for example "os.date('%H:%M'))" can be added to show the current time
					lualine_x = {
						{
							"lsp_status",
							ignore_lsp = { "null-ls", "GitHub Copilot" },
						},
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "oil", "trouble" },
			})
		end,
	},
}
