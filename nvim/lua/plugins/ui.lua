return {
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local tmux_nav = require("nvim-tmux-navigation")
      tmux_nav.setup({})
      vim.keymap.set("n", "<C-h>", tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", tmux_nav.NvimTmuxNavigateRight)
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
      size = 10,
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
}
