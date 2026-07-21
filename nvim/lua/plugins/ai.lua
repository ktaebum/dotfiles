return {
  {
    "github/copilot.vim",
    tag = "v1.58.0",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set(
        "i",
        "<C-j>",
        'copilot#Accept("<CR>")',
        { expr = true, silent = true, replace_keycodes = false }
      )
    end,
  },
}
