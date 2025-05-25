return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {
        -- lualine_a = { "buffers" },
        -- lualine_c = { "filename" },
        -- lualine_z = { "tabs" },
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function ()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          numbers = "buffer_id",
          diagnostics = "nvim_lsp",
          style_preset = bufferline.style_preset.default,
          indicator = {
            style = "underline",
          },
          separator_style = "thick",
          sort_by = "relative_directory",
        }
      })
    end
  }
}
