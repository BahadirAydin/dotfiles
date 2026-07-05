return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
}
