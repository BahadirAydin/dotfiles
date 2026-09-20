return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		init = function()
			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.g.disable_autoformat = true
				else
					vim.b.disable_autoformat = true
				end
			end, { desc = "Disable format-on-save (! = all buffers)", bang = true })

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "Re-enable format-on-save" })
		end,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_organize_imports", "ruff_format" },
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
			format_on_save = function(bufnr)
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
					return
				end

				return {
					timeout_ms = 1000,
					lsp_format = "fallback",
				}
			end,
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
