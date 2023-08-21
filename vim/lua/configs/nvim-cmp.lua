local status, nvimCmp = pcall(require, "cmp")

if not status then
  return
end

nvimCmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = nvimCmp.mapping.select_prev_item(),
    ['<C-n>'] = nvimCmp.mapping.select_next_item(),
    ['<C-d>'] = nvimCmp.mapping.scroll_docs(-4),
    ['<C-f>'] = nvimCmp.mapping.scroll_docs(4),
    ['<C-e>'] = nvimCmp.mapping({
          i = nvimCmp.mapping.abort(),
          c = nvimCmp.mapping.close(),
    }),
    ['<C-Space>'] = nvimCmp.mapping(nvimCmp.mapping.complete(), { 'i', 'c' }),
    ['<C-l>'] = nvimCmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }
})

-- Set configuration for specific filetype.
nvimCmp.setup.filetype('gitcommit', {
  sources = nvimCmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
nvimCmp.setup.cmdline({'/', '?'}, {
  mapping = nvimCmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
nvimCmp.setup.cmdline(':', {
  mapping = nvimCmp.mapping.preset.cmdline(),
  sources = nvimCmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.cmd("set completeopt=menuone,noinsert,noselect")
