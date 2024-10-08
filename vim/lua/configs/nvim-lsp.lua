local status, nvimLsp = pcall(require, "lspconfig")

if not status then
  return
end

local navic = require("nvim-navic")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local diagnostic_servers = {
  "clangd", -- C++ / C
  "pyright", -- Python
  "vimls", -- Vim
  "ts_ls", -- Typescript
  "gopls", -- Go
  "cmake", -- Cmake
  "texlab", -- Latex
  "lua_ls", -- Lua
  "bashls", -- Bash
  "jsonls", -- Json
  "docker_compose_language_service", -- docker-compose
  "dockerls", -- Dockerfile
  "rust_analyzer", -- Rust
  "yamlls" -- yaml
}

local non_diagnostic_servers = {
}

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

for _, lsp in ipairs(non_diagnostic_servers) do
  nvimLsp[lsp].setup({
    capabilities = capabilities,
    handlers = { ["textDocument/publishDiagnostics"] = function(...) end },
    on_attach = on_attach,
  })
end

for _, lsp in ipairs(diagnostic_servers) do
  nvimLsp[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

vim.lsp.set_log_level("off")
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  -- vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = false
  -- }
-- )
