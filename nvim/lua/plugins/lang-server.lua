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
      lspconfig.cmake.setup ({})
      lspconfig.docker_compose_language_service.setup ({})
      lspconfig.dockerls.setup ({})
      lspconfig.markdown_oxide.setup ({})
    end
  }
}
