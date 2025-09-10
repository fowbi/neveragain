return {
  {
    "stevearc/conform.nvim",
    optional = true,
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters = {
        php_cs_fixer = {
          env = {
            PHP_CS_FIXER_IGNORE_ENV = 1,
          },
        },
        sf_scanner = {
          command = "sf",
          timeout_ms = 5000,
          args = { "scanner", "run", "--format", "json" },
          -- Use a custom parsing function to handle the JSON output from sf scanner
          parse_json = function(json)
            local diagnostics = {}
            for _, issue in ipairs(json) do
              local diag = {
                row = issue.location.line - 1, -- Adjust for zero-based indexing
                col = issue.location.column - 1,
                message = issue.message,
                severity = issue.severity == "ERROR" and vim.diagnostic.severity.Error
                  or vim.diagnostic.severity.Warning,
                code = issue.ruleName,
                source = "sf scanner",
              }
              table.insert(diagnostics, diag)
            end
            return diagnostics
          end,
        },
        linters = {
          sf_scanner = {
            command = "sf",
            timeout_ms = 5000,
            args = { "scanner", "run", "--format", "json" },
            -- Use a custom parsing function to handle the JSON output from sf scanner
            parse_json = function(json)
              local diagnostics = {}
              for _, issue in ipairs(json) do
                local diag = {
                  row = issue.location.line - 1, -- Adjust for zero-based indexing
                  col = issue.location.column - 1,
                  message = issue.message,
                  severity = issue.severity == "ERROR" and vim.diagnostic.severity.Error
                    or vim.diagnostic.severity.Warning,
                  code = issue.ruleName,
                  source = "sf scanner",
                }
                table.insert(diagnostics, diag)
              end
              return diagnostics
            end,
          },
        },
      },
      formatters_by_ft = {
        go = { "gofmt", "goimports" },
        -- apexcode = { "sf_scanner" },
      },
      -- linters_by_ft = {
      --   apexcode = { "sf_scanner" },
      -- },
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
