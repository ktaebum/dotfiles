local status, nvimLsp = pcall(require, "lspconfig")

if not status then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = {
  "clangd", -- C++ / C
  "vimls", -- Vim
  "pyright", -- Python
  "tsserver", -- Typescript
  "gopls", -- Go
  "cmake", -- Cmake
  "texlab", -- Latex
  "lua_ls", -- Lua
}

for _, lsp in ipairs(servers) do
  nvimLsp[lsp].setup({
    capabilities = capabilities,
    handlers = { ["textDocument/publishDiagnostics"] = function(...) end },
  })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)
