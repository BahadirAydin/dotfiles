-- ============================================================
-- Bootstrap lazy.nvim
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Leader keys
-- ============================================================
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

-- ============================================================
-- General options
-- ============================================================
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.scrolloff = 10

-- avoid breaking up a word when breaking a line
vim.opt.linebreak = true

-- set tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- searching for hello matches hello, Hello, and HELLO.
vim.opt.ignorecase = true
-- searching for Hello matches only Hello
vim.opt.smartcase = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- set cursorline number and its highlight color
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number" -- only highlight the number not the line

-- update time (default 4000)
vim.opt.updatetime = 250

-- reserve sign column space to avoid text shifting
vim.opt.signcolumn = "yes"

-- ============================================================
-- Keymaps
-- ============================================================
vim.keymap.set("n", "<C-l>", "<cmd>noh<CR>", { silent = true, desc = "Clear search highlight." })

-- Turkish-Q puts ğ/ü on the physical keys that carry [/] on a US layout, and
-- the real brackets need AltGr, which makes every ]q, ]d and ]c motion a chord.
-- Alias the letters back in the modes where they are commands rather than text,
for lhs, rhs in pairs({ ["ğ"] = "[", ["ü"] = "]", ["Ğ"] = "{", ["Ü"] = "}" }) do
	vim.keymap.set({ "n", "x", "o" }, lhs, rhs, { remap = true })
end

-- ============================================================
-- Plugins
-- ============================================================
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
