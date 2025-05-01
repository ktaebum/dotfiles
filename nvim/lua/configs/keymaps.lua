-- Key mappings

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("n", "<TAB>", "<CMD>bn<CR>")
map("n", "<leader>=", "<CMD>vertical resize +10<CR>")
map("n", "<leader>9", "<CMD>vertical resize -10<CR>")
map("n", "<leader>-", "<CMD>resize +10<CR>")
map("n", "<leader>0", "<CMD>resize -10<CR>")
map("n", "<leader>m", "<C-W><Bar><C-W>_")
map("n", "<leader>n", "<C-W>1<Bar>")
map("i", "<C-c>", "<ESC>")
map("n", "<C-e>", "<C-W>=")
map("n", "<C-v>", "<CMD>vs<CR>")
map("n", "<C-W>v", "<CMD>sp<CR>")
map("n", "<C-p>", "<CMD>bp<CR>")
map("n", "<C-o>", "<CMD>ToggleTerm<CR>")
map("n", ";", ":")
-- map("n", "<leader>fo", function() vim.lsp.buf.format { async = true } end)
