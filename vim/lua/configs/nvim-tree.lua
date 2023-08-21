local status, nvimTree = pcall(require, "nvim-tree")

if not status then
  return
end

nvimTree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
