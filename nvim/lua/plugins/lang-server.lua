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
      vim.lsp.config("lua_ls", {})
      vim.lsp.config("rust_analyzer", {})
      vim.lsp.config("clangd", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("cmake", {})
      vim.lsp.config("docker_compose_language_service", {})
      vim.lsp.config("dockerls", {})
      vim.lsp.config("markdown_oxide", {})
    end
  }
}
