return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				objc = { "clang_format" },
				objcpp = { "clang_format" },
				go = { "gofmt" },
				cmake = { "gersemi" },
				sql = { "sqlfluff" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				svelte = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				postcss = { "prettierd" },
				mdx = { "prettierd" },
			},
			formatters = {
				sqlfluff = { append_args = { "--dialect", "postgres" } },
			},
			format_on_save = {},
		},
		keys = {
			{
				"<leader>ss",
				function()
					require("conform").format({ lsp_format = "fallback" })
				end,
				desc = "Format file",
			},
		},
	},
}
