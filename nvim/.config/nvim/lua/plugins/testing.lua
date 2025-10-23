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
            phpunit_cmd = function(args)
              local test_args = args or ""
              if string.find(vim.fn.getcwd(), "bff") then
                local script_path = vim.fn.stdpath("config") .. "/craftzing/itsme/test"
                local project_dir = vim.fn.getcwd()

                return script_path .. " " .. project_dir .. " " .. test_args
              else
                return "vendor/bin/phpunit" .. test_args
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
