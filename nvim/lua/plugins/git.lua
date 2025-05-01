return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy"
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy"
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
      "echasnovski/mini.pick",         -- optional
    },
  }
}
