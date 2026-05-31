-- 1. vim options

require("configs.options")

-- 2. key mapping

require("configs.keymaps")

-- 3. lsp

-- require("configs.lsp")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out =
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.lsp.log.set_level(vim.log.levels.ERROR)

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "cpp",
    "c",
    "cuda",
    "lua",
    "python",
    "rust",
    "go",
    "gitignore",
    "gitcommit",
    "vim",
    "zsh",
  },
  callback = function()
    vim.treesitter.start()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
