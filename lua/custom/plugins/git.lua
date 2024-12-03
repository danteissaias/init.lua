return {
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<Leader>gb", ":Gitsigns blame<CR>", silent = true },
    },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<Leader>ng", ":Neogit<CR>", silent = true },
    },
    init = function()
      local neogit = require "neogit"
      neogit.setup { graph_style = "kitty" }
    end,
  },
}
