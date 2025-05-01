return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function ()
      require("mason").setup {}
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup ({})
      lspconfig.rust_analyzer.setup({})
      lspconfig.clangd.setup ({})
      lspconfig.pyright.setup ({})
    end
  }
}
