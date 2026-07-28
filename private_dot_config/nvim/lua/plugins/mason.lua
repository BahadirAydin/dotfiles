return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			auto_update = false,
			ensure_installed = {
				-- language servers
				"clangd",
				"cmake-language-server",
				"basedpyright",
				"ruff",
				"json-lsp",
				"yaml-language-server",
				"marksman",
				"rust-analyzer",
				-- formatters
				"stylua",
				"clang-format",
				"gersemi",
				"prettierd",
			},
		},
	},
}
