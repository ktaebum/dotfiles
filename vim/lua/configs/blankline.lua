local status, blankline = pcall(require, "indend_blankline")

if not status then
  return
end

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

blankline.setup({
  show_end_of_line = true,
})
