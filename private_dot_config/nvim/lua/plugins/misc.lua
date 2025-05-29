return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			default_file_explorer = true,
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>o",
				"<cmd>Oil --float<CR>",
				{ silent = true },
				desc = "Open filesystem explorer in floating window",
			},
		},
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = true,
		enabled = vim.fn.isdirectory(vim.fn.expand("~/BahadirAydin/Notes")) == 1,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"saghen/blink.cmp",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>no", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open" },
			{ "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Find Files" },
			{ "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
		},
		opts = {
			dir = "~/BahadirAydin/Notes",
			daily_notes = {
				folder = "Günlük",
				date_format = "%Y-%m-%d",
			},
			ui = {
				enable = false,
				checkboxes = {
					[" "] = { char = "󱍫", hl_group = "DiagnosticInfo" },
					["x"] = { char = "󱍧", hl_group = "DiagnosticOk" },
					["/"] = { char = "󱍬", hl_group = "DiagnosticWarn" },
					["%-"] = { char = "󱍮", hl_group = "DiagnosticError" },
					["%?"] = { char = "󱍥", hl_group = "DiagnosticWarn" },
				},
			},
			completion = {
				nvim_cmp = false,
				blink = true,
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
			finder = "fzf-lua",
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
	{
		"folke/zen-mode.nvim",
		opts = {},
	},
}
