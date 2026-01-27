return {
  {
    "github/copilot.vim",
    tag = "v1.58.0",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set(
        "i",
        "<C-j>",
        'copilot#Accept("<CR>")',
        { expr = true, silent = true, replace_keycodes = false }
      )
    end,
  },
  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-opus-4-5",
          timeout = 30000, -- Timeout in milliseconds
          extra_request_body = {
            temperature = 0.2,
            max_tokens = 20480,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-mini/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   -- Pin to v17.33.0 to avoid breaking changes
  --   -- See: https://github.com/olimorris/codecompanion.nvim/pull/2439
  --   tag = "v17.33.0",
  --   opts = {},
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "anthropic",
  --           model = "claude-opus-4-5-20251101",
  --         },
  --         inline = {
  --           adapter = "anthropic",
  --           model = "claude-opus-4-5-20251101",
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        keymaps = {
          toggle = {
            normal = "<C-x>,", -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = "<C-x>,", -- Terminal mode keymap for toggling Claude Code, false to disable
            variants = {
              continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
              verbose = "<leader>cV", -- Normal mode keymap for Claude Code with verbose flag
            },
          },
        },
      })
    end,
  },
}
