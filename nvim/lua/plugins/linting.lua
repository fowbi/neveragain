return {
  {
    "stevearc/conform.nvim",
    optional = true,
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        php_cs_fixer = {
          env = {
            PHP_CS_FIXER_IGNORE_ENV = 1,
          },
        },
      },
      formatters_by_ft = {
        go = { "gofmt", "goimports" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      vue = { "eslint_d" },
      go = { "golangcilint" },
      -- Remove phpcs linter.
      linters_by_ft = {
        php = {},
      },
    },
  },
}
