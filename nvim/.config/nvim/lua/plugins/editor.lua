return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    -- keys = {
    --   {
    --     "<leader>o",
    --     function()
    --       require("oil").open()
    --     end,
    --     desc = "Open oil",
    --   },
    -- },
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        position = "center",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      opleader = {
        block = "gt",
      },
      toggler = {
        block = "gtc",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
      animate = { enabled = false },
    },
  },
}
