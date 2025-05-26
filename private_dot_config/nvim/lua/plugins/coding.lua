return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "markdown", "grug-far" },
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"aznhe21/actions-preview.nvim",
		opts = {},
		keys = {
			{ "<leader>ca", "<cmd>lua require('actions-preview').code_actions()<cr>", desc = "Code Actions Preview" },
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local language_servers = require("lspconfig").util.available_servers()
			for _, ls in ipairs(language_servers) do
				require("lspconfig")[ls].setup({
					capabilities = capabilities,
				})
			end
			require("ufo").setup()
		end,
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			startInInsertMode = false,
		},
		keys = {
			{
				"<leader>s;",
				function()
					require("grug-far").open({})
				end,
				desc = "GrugFar",
			},
			{
				"<leader>s;",
				function()
					require("grug-far").with_visual_selection({
						prefills = {
							search = vim.fn.expand("<cword>"),
							filesFilter = vim.fn.expand("%"),
						},
					})
				end,
				mode = "v",
				desc = "GrugFar",
			},
		},
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = { disabled_filetypes = { "cmake_tools_terminal" } },
	},
}
