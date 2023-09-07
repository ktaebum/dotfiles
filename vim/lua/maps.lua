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
map("x", "<leader>gl", ":'<,'>GetCurrentCommitLink<CR>")
map("n", "<leader>gl", "<CMD>GetCurrentCommitLink<CR>")

local treeStatus, nvimTree = pcall(require, "nvim-tree")
if treeStatus then
  map("n", "<leader>t", "<CMD>NvimTreeToggle<CR>")
  map("n", "<leader>r", "<CMD>NvimTreeFindFile<CR>")
end

local telescopeStatus, telescope = pcall(require, "telescope.builtin")
if telescopeStatus then
  map("n", "<leader>ff", telescope.find_files)
  map("n", "<leader>fg", telescope.live_grep)
  map("n", "<leader>fb", telescope.buffers)
  map("n", "<leader>fh", telescope.help_tags)
  map("n", "<leader>fs", telescope.git_status)
  map("n", "<leader>fc", telescope.git_commits)
end

local tmuxStatus, tmuxNavigation = pcall(require, "nvim-tmux-navigation")
if tmuxStatus then
  map("n", "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>")
  map("n", "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>")
  map("n", "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>")
  map("n", "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>")
end
