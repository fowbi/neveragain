return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- No `build` here: LazyVim's own build step makes sure the tree-sitter CLI
    -- exists before running :TSUpdate. Overriding it with ":TSUpdate" skipped
    -- that check, so parsers silently stopped compiling while queries updated.
    -- ensure_installed is merged with LazyVim's list (opts_extend).
    opts = {
      ensure_installed = { "php", "lua", "vim", "vimdoc", "go" },
    },
  },
}
