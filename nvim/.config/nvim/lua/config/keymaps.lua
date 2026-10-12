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

-- Pick a snippet available in the current buffer and expand it at the cursor
keymap("n", "<leader>sy", function()
  local ls = require("luasnip")
  local line = vim.api.nvim_get_current_line():sub(1, vim.fn.col("."))
  local items = {}
  -- Descriptions and docstrings can be either a string or a list of lines
  local function join(v)
    return type(v) == "table" and table.concat(v, "\n") or (v or "")
  end

  for _, ft in ipairs(ls.get_snippet_filetypes()) do
    for _, snip in ipairs(ls.get_snippets(ft)) do
      if not snip.hidden and snip.show_condition(line) then
        local desc = join(snip.description):gsub("\n", " ")
        if desc == snip.trigger then
          desc = ""
        end
        table.insert(items, {
          text = snip.trigger .. " " .. desc,
          trigger = snip.trigger,
          desc = desc,
          ft = ft,
          snip = snip,
          preview = { text = join(snip:get_docstring()), ft = vim.bo.filetype },
        })
      end
    end
  end

  Snacks.picker.pick({
    title = "Snippets",
    items = items,
    preview = "preview",
    format = function(item)
      return {
        { ("%-10s"):format(item.trigger), "SnacksPickerLabel" },
        { " " .. item.desc },
        { " [" .. item.ft .. "]", "SnacksPickerComment" },
      }
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.schedule(function()
          ls.snip_expand(item.snip)
        end)
      end
    end,
  })
end, { desc = "Snippets" })
