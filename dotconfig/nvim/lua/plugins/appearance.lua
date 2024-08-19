return {
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background",
				virtual_symbol = "■",
				enable_tailwind = true,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.8",
		config = function()
			require("indent_blankline").setup({
				char = "",
				context_char = "│",
				filetype_exclude = { "text", "help", "markdown", "dashboard", "neo-tree" },
				buftype_exclude = { "terminal", "nofile", "quickfix" },
				show_current_context = true,
				-- show_current_context_start = true,
				strict_tabs = true,
				show_trailing_blankline_indent = false,
				max_indent_increase = 1,
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = true,
			highlight = {
				multiline = false,
				keyword = "",
				before = "",
				after = "fg",
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
