return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
			vim.g.copilot_filetypes = {
				["*"] = false,
				["lua"] = true,
				["rust"] = true,
				["c"] = true,
				["c#"] = true,
				["cpp"] = true,
				["css"] = true,
				["go"] = true,
				["python"] = true,
				["md"] = true,
				["markdown"] = true,
				["tex"] = true,
				["javascript"] = true,
				["typescript"] = true,
				["svelte"] = true,
				["matlab"] = true,
				["html"] = true,
				["asm"] = true,
				["s"] = true,
				["sql"] = true,
			}
		end,
	},
}
