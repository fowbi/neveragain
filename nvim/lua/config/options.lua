-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

vim.opt.colorcolumn = "80,120"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#550000" })
