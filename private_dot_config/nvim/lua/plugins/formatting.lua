return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.cmake_format,
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "postgres" },
				}),
			},
		})
	end,
	keys = {
		{ "<leader>ss", "<cmd>lua vim.lsp.buf.format({timeout_ms=4000})<CR>", desc = "Format file." },
	},
}
