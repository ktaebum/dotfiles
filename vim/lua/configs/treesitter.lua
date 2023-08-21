local status, ts = pcall(require, "nvim-treesitter.configs")

if not status then
  return
end

ts.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ensure_installed = {
    "bibtex",
    "c",
    "cmake",
    "cpp",
    "cuda",
    "gitcommit",
    "gitignore",
    "git_config",
    "git_rebase",
    "lua",
    "python",
    "vim",
  },
  auto_install = true,
  sync_install = true,
})
