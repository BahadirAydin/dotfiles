return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		lazy = true,
		event = "InsertEnter",
		build = vim.fn.executable("make") == 1 and "make install_jsregexp" or nil,
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			region_check_events = "InsertEnter",
			delete_check_events = "InsertLeave",
		},
		config = function(_, opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
		end,
	},
}
