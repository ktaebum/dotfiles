local status, bufferline = pcall(require, "bufferline")

if not status then
  return
end

bufferline.setup({
  options = {
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    style_preset = bufferline.style_preset.minimal,
  }
})
