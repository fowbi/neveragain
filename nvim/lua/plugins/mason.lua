return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "jdtls",
        "google-java-format",
      },
    },
  },
}
