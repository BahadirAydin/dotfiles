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
			ruff = {},
			jsonls = {},
			yamlls = {},
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
		vim.diagnostic.config({
			virtual_lines = false,
			severity_sort = true,
		})

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
		vim.keymap.set("n", "<space>q", function()
			vim.diagnostic.setloclist({ open = false })
			require("trouble").open({ mode = "loclist", focus = true })
		end, { desc = "Diagnostic location list (Trouble)" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
				end
				-- Everything else (rename, references, implementation, type
				-- definition, hover, signature help, codelens) is a Neovim 0.11
				-- built-in under `gr`, `K` and `<C-s>`. Only definition and
				-- declaration have no built-in, so they are all that is left here.
				-- which-key labels the built-ins, see misc.lua.
				map("gd", vim.lsp.buf.definition, "Definition")
				map("gD", vim.lsp.buf.declaration, "Declaration")
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
