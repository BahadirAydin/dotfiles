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
			"<cmd>lua vim.diagnostic.open_float(nil,{focus=false, border='single'})<CR>",
			{ silent = true, desc = "Floating diagnostics window." }
		)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { desc = "Prev diagnostic" })
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { desc = "Next diagnostic" })
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Diagnostic location list" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
				end
				map("gD", vim.lsp.buf.declaration, "LSP declaration")
				map("gd", vim.lsp.buf.definition, "LSP definition")
				map("K", vim.lsp.buf.hover, "LSP hover")
				map("gi", vim.lsp.buf.implementation, "LSP implementation")
				map("<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
				map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
				map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
				map("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "List workspace folders")
				map("<leader>D", vim.lsp.buf.type_definition, "LSP type definition")
				map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
				map("gr", vim.lsp.buf.references, "LSP references")
			end,
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities or {})
			config.capabilities.textDocument = vim.tbl_deep_extend("force", config.capabilities.textDocument or {}, {
				foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
			})
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
