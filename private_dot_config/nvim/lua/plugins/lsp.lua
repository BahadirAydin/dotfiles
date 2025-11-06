local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			clangd = {
				cmd = {
					"clangd",
					"--clang-tidy",
					"--background-index",
					"--background-index-priority=background",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"-j",
					"2",
				},
				root_dir = function()
					local util = require("lspconfig.util")
					return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")
				end,
				capabilities = {
					offsetEncoding = { "utf-8" },
				},
				settings = {
					clangd = {
						semanticHighlighting = true,
					},
				},
			},
			cmake = {},
			basedpyright = {},
			marksman = {
				filetypes = { "markdown", "mdx" },
			},
			rust_analyzer = {},
			svelte = {},
			gopls = {},
			tailwindcss = {
				filetypes = {
					"html",
					"mdx",
					"css",
					"postcss",
					"sass",
					"scss",
					"javascript",
					"typescript",
					"svelte",
				},
			},
			ts_ls = {},
			texlab = {},
		},
	},
	config = function(_, opts)
		-- vim.diagnostic.config({
		-- 	virtual_text = false,
		-- })

		vim.keymap.set(
			"n",
			"<leader><tab>",
			"<cmd>lua vim.diagnostic.open_float(nil,{focus=false})<CR>",
			{ silent = true, desc = "Floating diagnostics window." }
		)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ss", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities or {})
			vim.lsp.config(server, config)
		end

		vim.lsp.enable(vim.tbl_keys(opts.servers))
	end,
}

return {
	M,
	{
		"p00f/clangd_extensions.nvim",
		opts = {},
		ft = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
		keys = {
			{ "<leader>sh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source Header" },
		},
	},
}
