return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "php", "lua", "vim", "vimdoc", "go", "java" },
    },
  },
}

