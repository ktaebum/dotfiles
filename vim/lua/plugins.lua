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
  -- use("nvim-treesitter/nvim-treesitter-context")

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
  use("knsh14/vim-github-link")

  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    config = function()
      require("configs.lualine")
    end,
    requires = { "nvim-tree/nvim-web-devicons", opt = true }
  })
  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("configs.bufferline")
    end,
  })

  -- Blankline
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("configs.blankline")
    end,
  })

  -- LSP / Completions
  use({
    "neovim/nvim-lspconfig",
  })
  use({
    "williamboman/mason.nvim",
    config = function()
      require("configs.mason")
    end,
  })
  use("onsails/lspkind-nvim")
  use({
    "L3MON4D3/LuaSnip",
    tag = "v2.*",
    run = "make install_jsregexp",
  })
  use({
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp"
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
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  })
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })
  use("simrat39/rust-tools.nvim")

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
  use("Vimjas/vim-python-pep8-indent")

  -- Terminal
  use({
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("configs.toggleterm")
    end
  })

  -- Comment
  use({
    "numToStr/Comment.nvim",
    config = function()
      require('configs.comment')
    end
  })
  use({
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end
  })

  -- Linter / Debugging
  use({
    "folke/trouble.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })

  -- Key Bindings
  use({
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  })

  -- ChatGPT
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("configs.chatgpt")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- Avante
  use("stevearc/dressing.nvim")
  use("MunifTanjim/nui.nvim")
  use("MeanderingProgrammer/render-markdown.nvim")
  use("HakonHarnes/img-clip.nvim")
  use({
    "yetone/avante.nvim",
    branch = "v0.0.23",
    run = "make",
    config = function()
      require("configs.avante").setup()
    end
  })

  -- Colorscheme
  use("rebelot/kanagawa.nvim")
  use("loctvl842/monokai-pro.nvim")
  use("projekt0n/github-nvim-theme")
  use("Mofiqul/vscode.nvim")
  use("sainnhe/everforest")
  use("Mofiqul/dracula.nvim")
  use("folke/tokyonight.nvim")
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use("EdenEast/nightfox.nvim")
  use({
    "rose-pine/neovim",
    as = "rose-pine"
  })
  use({
    "bluz71/vim-nightfly-colors",
    as = "nightfly"
  })
  use({
    "bluz71/vim-moonfly-colors",
    as = "moonfly"
  })
  use("AlexvZyl/nordic.nvim")
  use({
    "kepano/flexoki-neovim",
    as = "flexoki"
  })
  use("ellisonleao/gruvbox.nvim")
  use("olimorris/onedarkpro.nvim")
  use("shaunsingh/nord.nvim")
  use("Shatur/neovim-ayu")
  use("marko-cerovac/material.nvim")
end)
