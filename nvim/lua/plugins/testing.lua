return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function() end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-phpunit",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-java")({}),
          require("neotest-phpunit")({
            phpunit_cmd = function()
              if string.find(vim.fn.getcwd(), "bff") then
                return vim.fn.getcwd() .. "/imtest"
              else
                return "vendor/bin/phpunit"
              end
            end,
          }),
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "java",
      },
    },
  },
}
