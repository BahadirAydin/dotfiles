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
			-- Deliberately shadows the built-in `gra` rather than adding a third
			-- key. Visual mode matters: clangd's extract function / extract
			-- variable only appear for a selected range.
			{
				"gra",
				function()
					require("actions-preview").code_actions()
				end,
				mode = { "n", "x" },
				desc = "Code action (preview)",
			},
		},
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
		opts = {
			disabled_filetypes = {
				-- Matched as lua patterns, so the dash has to be escaped. Covers
				-- dap-view, -term, -help and -hover in one entry.
				"dap%-view.*",
				"neotest%-output.*",
				"cmake_tools_terminal",
				"neo-tree",
				"TelescopePrompt",
				"snacks_input",
				"snacks_picker_input",
				"fzf-lua",
				"oil",
				"markdown",
				"noice",
				"help",
				"lazy",
				"mason",
			},
		},
	},
}
