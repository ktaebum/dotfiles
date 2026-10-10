return {
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    cond = function()
      return vim.env.HERDR_PANE_ID == nil
    end,
  },
  {
    "bojackduy/nvim-herdr-navigation",
    submodules = false,
    cond = function()
      return vim.env.HERDR_PANE_ID ~= nil
    end,
    event = "VeryLazy",
    init = function(plugin)
      vim.opt.rtp:prepend(plugin.dir .. "/nvim-herdr-navigation")
    end,
    config = function()
      vim.schedule(function()
        require("herdr-navigation").setup({
          keybindings = {
            left = "<C-h>",
            down = "<C-j>",
            up = "<C-k>",
            right = "<C-l>",
          },
        })
      end)
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
