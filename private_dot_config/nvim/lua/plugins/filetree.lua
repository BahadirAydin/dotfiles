return {
	"folke/snacks.nvim",
	opts = {},
	keys = {
		{
			"<leader>e",
			function()
				local pickers = Snacks.picker.get({ source = "explorer" })
				if pickers and #pickers > 0 then
					pickers[1]:close()
				else
					Snacks.explorer()
				end
			end,
			desc = "Toggle Snacks Explorer",
		},
	},
}
