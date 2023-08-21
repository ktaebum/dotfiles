local status, toggleterm = pcall(require, "toggleterm")

if not status then
  return
end

toggleterm.setup({
  size = 10,
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
