return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        -- "apex_ls",
        "jdtls",
        "google-java-format",
      },
    },
  },
}
