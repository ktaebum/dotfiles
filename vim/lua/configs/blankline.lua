local status, blankline = pcall(require, "indent_blankline")

if not status then
  return
end

vim.opt.list = true

blankline.setup({
  show_end_of_line = true,
  show_trailing_blankline_indent = true,
})
