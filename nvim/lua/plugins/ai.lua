return {
  {
    "github/copilot.vim",
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
    "olimorris/codecompanion.nvim",
    -- Pin to v17.33.0 to avoid breaking changes
    -- See: https://github.com/olimorris/codecompanion.nvim/pull/2439
    tag = "v17.33.0",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
            model = "claude-opus-4-5-20251101",
          },
          inline = {
            adapter = "anthropic",
            model = "claude-opus-4-5-20251101",
          },
        },
      })
    end,
  },
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
