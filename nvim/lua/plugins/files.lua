return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local nvim_tree = require("nvim-tree")
      nvim_tree.setup({
        sort_by = "case_sensitive",
        view = {
          width = 50,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          ignore = false,
        },
      })
      vim.keymap.set("n", "<leader>t", "<CMD>NvimTreeToggle<CR>", { silent = true })
      vim.keymap.set("n", "<leader>r", "<CMD>NvimTreeFindFile<CR>", { silent = true })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    event = "VeryLazy",
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      -- vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Telescope git status" })
      vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Telescope git commits" })
      vim.keymap.set("n", "<leader>ft", builtin.tags, { desc = "Telescope tags" })

      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_config = {
            vertical = { width = 80 },
          },
        },
        pickers = {
          find_files = { theme = "dropdown" },
          live_grep = { theme = "ivy" },
          buffers = { theme = "ivy" },
          git_status = { theme = "ivy" },
          git_commits = { theme = "ivy" },
          git_files = { theme = "ivy" },
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
