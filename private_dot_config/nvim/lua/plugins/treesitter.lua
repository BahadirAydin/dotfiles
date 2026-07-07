return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				-- core nvim
				"regex",
				"vim",
				"vimdoc",
				"lua",
				"query",
				-- systems
				"c",
				"cpp",
				"go",
				"rust",
				"python",
				"bash",
				"cmake",
				"make",
				"ninja",
				-- web
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"scss",
				"svelte",
				-- docs/data
				"markdown",
				"markdown_inline",
				"latex",
				"json",
				"toml",
				"yaml",
				"xml",
				"sql",
				"jq",
				"diff",
				-- git
				"gitcommit",
				"gitignore",
				"git_rebase",
				"gitattributes",
				"git_config",
				-- ops
				"dockerfile",
				"just",
			})
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("UserTreesitter", {}),
				callback = function()
					if pcall(vim.treesitter.start) then
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end
				end,
			})
		end,
	},
}
