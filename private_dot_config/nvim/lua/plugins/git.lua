return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Git: next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Git: prev hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git: stage hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git: reset hunk" })

					map("x", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: stage selection" })

					map("x", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: reset selection" })

					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git: stage buffer" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git: reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git: preview hunk" })
					map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Git: preview hunk inline" })

					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Git: blame line" })

					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git: diff this" })

					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Git: diff this ~" })

					map("n", "<leader>hQ", function()
						gitsigns.setqflist("all")
					end, { desc = "Git: quickfix all hunks" })
					map("n", "<leader>hq", gitsigns.setqflist, { desc = "Git: quickfix hunks" })

					-- Toggles
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Git: toggle line blame" })
					map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Git: toggle deleted" })
					map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Git: toggle word diff" })

					-- Text object
					map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Git: select hunk" })
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
			"DiffviewRefresh",
		},
		opts = {},
		keys = {
			{ "<leader>dd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open", silent = true },
			{ "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview close", silent = true },
			{ "<leader>df", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview repo history", silent = true },
			{ "<leader>dF", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview file history", silent = true },
			{ "<leader>dr", "<cmd>DiffviewRefresh<CR>", desc = "Diffview refresh", silent = true },
			{ "<leader>do", "<cmd>DiffviewOpen origin/HEAD<CR>", desc = "Diffview vs origin/HEAD", silent = true },
			{ "<leader>dO", "<cmd>DiffviewOpen origin/HEAD -- %<CR>", desc = "Diffview current file vs origin/HEAD", silent = true },
			{ "<leader>dp", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "Diffview vs HEAD~1", silent = true },
			{ "<leader>dt", "<cmd>DiffviewToggleFiles<CR>", desc = "Diffview toggle files", silent = true },
			{ "<leader>dh", "<esc><cmd>'<,'>DiffviewFileHistory<CR>", mode = "x", desc = "Diffview selection history", silent = true },
		},
	},
}
