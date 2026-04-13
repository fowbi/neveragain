-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Large file handling: disable expensive features for files over 500KB
local big_file_size = 500 * 1024 -- 500KB

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
  callback = function(args)
    local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if not ok or not stat or stat.size < big_file_size then
      return
    end

    vim.b[args.buf].is_big_file = true

    -- Disable treesitter
    vim.api.nvim_create_autocmd("LspAttach", {
      buffer = args.buf,
      callback = function(ev)
        vim.lsp.buf_detach_client(ev.buf, ev.data.client_id)
      end,
    })

    vim.api.nvim_create_autocmd("BufReadPost", {
      buffer = args.buf,
      once = true,
      callback = function()
        -- Disable treesitter highlighting
        pcall(vim.treesitter.stop, args.buf)
        -- Fall back to basic syntax, then turn that off too for very large files
        vim.bo[args.buf].syntax = "off"
        -- Disable folding
        vim.wo.foldmethod = "manual"
        vim.wo.foldenable = false
        -- Disable undo history to save memory
        vim.bo[args.buf].undofile = false
        vim.bo[args.buf].swapfile = false
        vim.notify("Big file: LSP, treesitter and syntax disabled for performance", vim.log.levels.WARN)
      end,
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if vim.b[args.buf].is_big_file then
      return
    end
    require("conform").format({ bufnr = args.buf })
  end,
})
