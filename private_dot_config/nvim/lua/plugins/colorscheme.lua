return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		name = "kanagawa",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				on_colors = function(colors)
					colors.bg = "#14191e"
				end,
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme carbonfox]])
		end,
	},
	{
		"rose-pine/neovim",
		enabled = false,
		name = "rose-pine",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme rose-pine]])
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		enabled = false,
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd("colorscheme github_dark_default")
		end,
	},
}
