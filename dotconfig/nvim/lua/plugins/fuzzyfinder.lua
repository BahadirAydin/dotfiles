return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope Live Grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Telescope Buffers" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope Old Files" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Telescope LSP Diagnostics" },
			{ "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Telescope Command History" },
			{ "<leader>fa", "<cmd>Telescope aerial<cr>", desc = "Telescope Contexts" },
			{ "<leader>fs", "<cmd>Telescope spell_suggest<cr>", desc = "Telescope Spell Suggest" },
			{ "<leader>fy", "<cmd>Telescope neoclip<cr>", desc = "Telescope Spell Suggest" },
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").load_extension("aerial")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules/", "build/", "target/", "vendor/" },
					mappings = {
						i = {
							["<esc>"] = actions.close,
						},
					},
					preview = {
						filesize_limit = 0.1, -- MB
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
					},
					buffers = {
						sort_lastused = true,
						ignore_current_buffer = true,
					},
					oldfiles = {
						sort_lastused = true,
					},
				},
			})
		end,
	},
}
