local M = {}

local function is_empty_buffer(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
    return false
  end
  return vim.api.nvim_buf_get_name(buf) == ""
    and vim.bo[buf].buftype == ""
    and vim.bo[buf].filetype == ""
    and vim.bo[buf].buflisted
    and not vim.bo[buf].modified
    and vim.api.nvim_buf_line_count(buf) == 1
    and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

function M.open(method, opts)
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local group = vim.api.nvim_create_augroup("FffEmptyBuffer", { clear = true })
  if is_empty_buffer(buf) then
    vim.api.nvim_create_autocmd("BufHidden", {
      group = group,
      buffer = buf,
      once = true,
      callback = function()
        -- FFF may defer the file open until its floating windows are closed.
        vim.schedule(function()
          if not is_empty_buffer(buf) or not vim.api.nvim_win_is_valid(win) then
            return
          end
          local replacement = vim.api.nvim_win_get_buf(win)
          if
            replacement ~= buf
            and vim.api.nvim_buf_get_name(replacement) ~= ""
            and vim.bo[replacement].buftype == ""
            and #vim.fn.win_findbuf(buf) == 0
          then
            vim.api.nvim_buf_delete(buf, { force = false })
          end
        end)
      end,
    })
  end
  require("fff")[method](opts)
end

return M
