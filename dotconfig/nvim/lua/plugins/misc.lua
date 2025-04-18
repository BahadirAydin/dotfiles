return {
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
			require("which-key").setup({})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		config = function()
			run = vim.fn["mkdp#util#install"]()
			ft = "markdown"
		end,
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>o",
				"<cmd>Oil --float<CR>",
				{ silent = true },
				desc = "Open filesystem explorer in floating window",
			},
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		opts = {},
		keys = {
			{
				"<leader>dd",
				"<cmd>DiffviewOpen<CR>",
				{ silent = true },
			},
		},
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = true,
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version= "*",
		lazy = true,
		event = { "BufReadPre /home/bahadir/BahadirAydin/Notes/**.md" },
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			dir = "~/BahadirAydin/Notes",
			daily_notes = {
				folder = "Günlük",
				date_format = "%Y-%d-%m",
			},

			completion = {
				nvim_cmp = true,
                blink = false,
				min_chars = 2,
			},
			note_id_func = function(title)
				-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
				-- In this case a note with the title 'My new note' will given an ID that looks
				-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,

			disable_frontmatter = false,

			-- templates = {
			-- 	subdir = "templates",
			--              date_format = "%d-%m-%Y-%a",
			-- 	time_format = "%M:%H",
			-- },

			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url })
			end,
			use_advanced_uri = true,
			finder = "telescope.nvim",
		},
		config = function(_, opts)
			-- vim.opt.conceallevel = 1
			require("obsidian").setup(opts)
			vim.keymap.set("n", "gf", function()
				if require("obsidian").util.cursor_on_markdown_link() then
					return "<cmd>ObsidianFollowLink<CR>"
				else
					return "gf"
				end
			end, { noremap = false, expr = true })
		end,
	},
}
