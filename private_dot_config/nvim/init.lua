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

vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.scrolloff = 10

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "<C-l>", "<cmd>noh<CR>", { silent = true, desc = "Clear search highlight." })
require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
-- avoid breaking up a word when breaking a line
vim.opt.linebreak = true
-- set tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- set cursorline number and its highlight color
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number" -- only highlight the number not the line
vim.api.nvim_set_hl(0, "CursorLineNr", { foreground = "#89b4fa" })

-- update time (default 4000)
vim.opt.updatetime = 250
