return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
	opts = {
		snippets = { preset = "luasnip" },
		-- ensure you have the `snippets` source (enabled by default)
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
