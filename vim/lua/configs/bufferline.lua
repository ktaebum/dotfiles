local status, bufferline = pcall(require, "bufferline")

if not status then
  return
end

bufferline.setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    style_preset = bufferline.style_preset.minimal,
  }
})
