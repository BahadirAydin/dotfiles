local prefix = "<leader>t"
local function key(suffix)
	return prefix .. suffix
end

local function run(opts)
	return function()
		require("neotest").run.run(opts)
	end
end

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"orjangj/neotest-ctest",
			"nvim-neotest/neotest-python",
		},
		opts = function()
			return {
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				adapters = {
					require("neotest-ctest").setup({
						-- foo_test.cpp and test_foo.cpp only. The upstream default
						-- accepts the suffix but not the prefix.
						is_test_file = function(file)
							local name, ext = file:match("([^/\\]+)%.(%w+)$")
							if not name or not vim.tbl_contains({ "cpp", "cc", "cxx" }, ext) then
								return false
							end
							return name:match("_test$") ~= nil or name:match("^test_") ~= nil
						end,
					}),
					require("neotest-python")({
						runner = "pytest",
					}),
				},
			}
		end,
		config = function(_, opts)
			require("neotest").setup(opts)
		end,
		keys = {
			{ key("t"), run(), desc = "Test: run nearest" },
			{
				key("f"),
				function()
					require("neotest").overseer.run(vim.fn.expand("%"))
				end,
				desc = "Test: run file",
			},
			{
				key("a"),
				function()
					require("neotest").overseer.run(vim.uv.cwd())
				end,
				desc = "Test: run all",
			},
			{ key("l"), run({ suite = false, last = true }), desc = "Test: run last" },
			{
				key("q"),
				function()
					require("neotest").overseer.stop()
				end,
				desc = "Test: stop",
			},
			{
				key("s"),
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Test: toggle summary",
			},
			{
				key("o"),
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "Test: show output",
			},
			{
				key("O"),
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Test: toggle output panel",
			},
			{
				key("w"),
				function()
					require("neotest").watch.toggle(vim.fn.expand("%"))
				end,
				desc = "Test: toggle watch",
			},
		},
	},
	{ "orjangj/neotest-ctest", lazy = true },
	{ "nvim-neotest/neotest-python", lazy = true },
}
