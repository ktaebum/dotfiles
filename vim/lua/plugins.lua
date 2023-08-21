vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
})

return require("packer").startup(function(use)
  -- Packer
  use("wbthomason/packer.nvim")

  -- Common
  use("nvim-lua/plenary.nvim")

  -- Syntax
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("configs.treesitter")
    end,
  })

  -- Tree search
  use("nvim-tree/nvim-web-devicons")
  use({
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("configs.nvim-tree")
    end,
  })

  -- File / tag navigators
  use("nvim-telescope/telescope.nvim")

  -- Git
  use("sindrets/diffview.nvim")
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.gitsigns")
    end,
  })

  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    config = function()
      require("configs.lualine")
    end,
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })

  -- LSP / Completions
  use({
    "neovim/nvim-lspconfig",
  })
  use("onsails/lspkind-nvim")
  use({
    "L3MON4D3/LuaSnip",
    tag = "v2.*",
    run = "make install_jsregexp",
  })
  use({
    "hrsh7th/cmp-nvim-lsp",
    config = function()
      require("configs.nvim-lsp")
    end,
  })
  use({
    "hrsh7th/cmp-path",
    after = "nvim-cmp"
  })
  use({
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp"
  })
  use({
    "hrsh7th/cmp-cmdline",
    after = "nvim-cmp"
  })
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("configs.nvim-cmp")
    end,
    event = "InsertEnter",
  })

  --- Tmux
  use("alexghergh/nvim-tmux-navigation")

  -- Markdown
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("configs.autopairs")
    end,
  })

  -- Terminal
  use({
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("configs.toggleterm")
    end
  })

  -- Colorscheme
  use("tanvirtin/monokai.nvim")
end)
