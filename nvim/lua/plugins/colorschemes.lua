return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = false, bold = true },
          functions = { bold = true },
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = true, -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,

        cache = true, -- When set to true, the theme will be cached for better performance

        ---@type table<string, boolean|{enabled:boolean}>
        plugins = {
          -- enable all plugins when not using lazy.nvim
          -- set to false to manually enable/disable plugins
          all = package.loaded.lazy == nil,
          -- uses your plugin manager to automatically enable needed plugins
          -- currently only lazy.nvim is supported
          auto = true,
          -- add any plugins here that you want to enable
          -- for all possible plugins, see:
          --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
          -- telescope = true,
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        -- optional configuration here
        -- Main options --
        -- NOTE: to use the light theme, set `vim.o.background = 'light'`
        style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
        toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
        toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
        transparent = false, -- Show/hide background
        dim_inactive = true, -- Dim inactive windows/buffers
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- Change code style ---
        -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
        -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
        code_style = {
          comments = { italic = true },
          conditionals = { italic = true },
          keywords = {},
          functions = {},
          namespaces = { italic = true },
          parameters = { italic = true },
          strings = { bold = true },
          variables = {},
        },

        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors
        highlights = {
          ["@comment"] = { fg = "$grey" },
          ["@lsp.type.comment"] = { link = "@comment" }
        }, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = false, -- darker colors for diagnostic
          undercurl = true, -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        },
      }
      -- require('bamboo').load()
    end,
  },
  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
    end
  },
  {
    'everviolet/nvim',
    name = 'evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
        accent = 'green',
      },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
          color = 'mantle',
          invert_border = false,
        },
        completion = {
          color = 'surface0',
        },
      },
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
      })
      -- vim.cmd("colorscheme rose-pine")
    end
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
      })
    end
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme("kanagawa-paper-ink")
    end,
    opts = {
      -- enable undercurls for underlined text
      undercurl = false,
      -- transparent background
      transparent = false,
      -- highlight background for the left gutter
      gutter = false,
      -- background for diagnostic virtual text
      diag_background = true,
      -- dim inactive windows. Disabled when transparent
      dim_inactive = true,
      -- set colors for terminal buffers
      terminal_colors = true,
      -- cache highlights and colors for faster startup.
      -- see Cache section for more details.
      cache = false,

      styles = {
        -- style for comments
        comment = { italic = true },
        -- style for functions
        functions = { italic = false },
        -- style for keywords
        keyword = { italic = false, bold = true },
        -- style for statements
        statement = { italic = false, bold = false },
        -- style for types
        type = { italic = false },
      },
      -- override default palette and theme colors
      colors = {
        palette = {},
        theme = {
          ink = {},
          canvas = {},
        },
      },
      -- adjust overall color balance for each theme [-1, 1]
      color_offset = {
        ink = { brightness = 0, saturation = 0 },
        canvas = { brightness = 0, saturation = 0 },
      },
      -- override highlight groups
      overrides = function(colors)
        return {}
      end,

      -- uses lazy.nvim, if installed, to automatically enable needed plugins
      auto_plugins = true,
      -- enable highlights for all plugins (disabled if using lazy.nvim)
      all_plugins = package.loaded.lazy == nil,
      -- manually enable/disable individual plugins.
      -- check the `groups/plugins` directory for the exact names
      plugins = {
        -- examples:
        -- rainbow_delimiters = true
        -- which_key = false
      },
    }
  },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {}, -- Optional
  }
}
