local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- lspconfig.apex_ls.setup({
--   apex_jar_path = "/Users/myname/.vscode/extensions/salesforce.salesforcedx-vscode-apex-63.2.3/dist/apex-jorje-lsp.jar",
--   apex_enable_semantic_errors = true, -- Whether to allow Apex Language Server to surface semantic errors
--   apex_enable_completion_statistics = false, -- Whether to allow Apex Language Server to collect telemetry on code completion usage
-- })

return {}
-- updated 2025-08-19
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       local lspconfig = require("lspconfig")
--
--       lspconfig.gopls.setup({
--         filetypes = { "go", "gomod", "gowork", "gotmpl" },
--         root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
--         settings = {
--           gopls = {
--             analyses = {
--               unusedparams = true,
--             },
--             staticcheck = true,
--           },
--         },
--       })
--     end,
--   },
-- }
