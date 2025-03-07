return {
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
}
