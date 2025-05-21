local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.diagnostic.config({
			virtual_text = false,
		})
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local clangd_capabilities = vim.deepcopy(capabilities)
		clangd_capabilities.offsetEncoding = "utf-8"
		require("lspconfig").clangd.setup({
			capabilities = clangd_capabilities,
			cmd = { "clangd", "--clang-tidy", "--background-index" },
		})
		require("lspconfig").pyright.setup({
			capabilities = capabilities,
		})
		require("lspconfig").texlab.setup({
			capabilities = capabilities,
		})
		require("lspconfig").rust_analyzer.setup({
			capabilities = capabilities,
		})
		require("lspconfig").svelte.setup({
			capabilities = capabilities,
		})
		require("lspconfig").gopls.setup({
			capabilities = capabilities,
		})
		require("lspconfig").tailwindcss.setup({
			capabilities = capabilities,
		})
		vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
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
				-- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})
	end,
}
return {
	M,
	{
		"p00f/clangd_extensions.nvim",
		opts = {},
		keys = {
			{ "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source Header" },
		},
	},
}
