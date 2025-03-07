local vo = vim.opt

vim.g.mapleader = ","

-- Show a line on 80 and 120 characters to visualize proper formatting
vo.colorcolumn = "80,120"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#550000" })

---- Relative numbers
vo.number = true
vo.relativenumber = true

-- Sets how neovim will display certain whitespace characters in the editor.
vo.list = true
vo.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
