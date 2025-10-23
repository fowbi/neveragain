-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Copy filepath of current file
keymap("n", "<leader>yp", function()
  local choices = {
    { label = "Relative to CWD", value = vim.fn.expand("%:.") },
    { label = "Absolute path", value = vim.fn.expand("%:p") },
    { label = "Relative path", value = vim.fn.expand("%") },
    { label = "Filename only", value = vim.fn.expand("%:t") },
  }

  vim.ui.select(choices, {
    prompt = "Copy file path:",
    format_item = function(item)
      return item.label .. " → " .. item.value
    end,
  }, function(choice)
    if choice then
      vim.fn.setreg("+", choice.value)
      vim.notify("Copied " .. choice.label .. ": " .. choice.value)
    end
  end)
end, { desc = "Yank file path (choose type)" })
