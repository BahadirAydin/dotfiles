return {
	-- {
	--   "catppuccin/nvim", name = "catppuccin",
	--   lazy = false,
	--   priority=1000,
	--   config = function()
	--       vim.cmd[[colorscheme catppuccin-mocha]]
	--   end,
	-- }
	-- {
	--   "rebelot/kanagawa.nvim", name = "kanagawa",
	--   lazy = false,
	--   priority=1000,
	--   config = function()
	--       vim.cmd[[colorscheme kanagawa]]
	--   end,
	-- }
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	name = "tokyonight",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("tokyonight").setup({
	--                on_colors = function(colors)
	--                    colors.bg = "#14191e"
	--                end
	--            })
	-- 		vim.cmd([[colorscheme tokyonight-night]])
	-- 	end,
	-- },
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme carbonfox]])
	-- 	end,
	-- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme rose-pine]])
		end,
	},
}
