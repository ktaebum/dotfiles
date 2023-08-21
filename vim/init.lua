require("settings")
require("plugins")
require("maps")

local themeStatus, theme = pcall(require, "monokai")

if themeStatus then
  vim.cmd("colorscheme monokai_pro")
else
  return
end
