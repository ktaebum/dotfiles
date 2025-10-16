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
      vim.lsp.enable("lua_ls", {})
      vim.lsp.enable("rust_analyzer", {})
      vim.lsp.enable("clangd", {})
      vim.lsp.enable("pyright", {})
      vim.lsp.enable("cmake", {})
      vim.lsp.enable("docker_compose_language_service", {})
      vim.lsp.enable("dockerls", {})
      vim.lsp.enable("markdown_oxide", {})
    end
  }
}
