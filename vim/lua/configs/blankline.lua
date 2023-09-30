local status, ibl = pcall(require, "ibl")

if not status then
  return
end

vim.opt.list = true

local highlight = {
  "Whitespace",
}

ibl.setup({
  indent = {
    highlight = highlight,
  },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  scope = {
    enabled = false,
  },
})
