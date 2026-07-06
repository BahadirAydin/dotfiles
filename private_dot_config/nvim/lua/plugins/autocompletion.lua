return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
	opts = {
		snippets = { preset = "luasnip" },
		appearance = { nerd_font_variant = "mono" },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},
			menu = { border = "rounded" },
			signature = {
				enabled = true,
				window = { border = "rounded" },
			},
		},
	},
}
