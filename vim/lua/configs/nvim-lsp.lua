local status, nvimLsp = pcall(require, "lspconfig")

if not status then
  return
end

local navic = require("nvim-navic")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local diagnostic_servers = {
  "pyright", -- Python
}
local non_diagnostic_servers = {
  "clangd", -- C++ / C
  "vimls", -- Vim
  "tsserver", -- Typescript
  "gopls", -- Go
  "cmake", -- Cmake
  "texlab", -- Latex
  "lua_ls", -- Lua
}

for _, lsp in ipairs(non_diagnostic_servers) do
  nvimLsp[lsp].setup({
    capabilities = capabilities,
    handlers = { ["textDocument/publishDiagnostics"] = function(...) end },
    on_attach = function(client, bufnr)
      navic.attach(client, bufnr)
    end,
  })
end

for _, lsp in ipairs(diagnostic_servers) do
  nvimLsp[lsp].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      navic.attach(client, bufnr)
    end,
  })
end
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  -- vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = false
  -- }
-- )
