local status, chatgpt = pcall(require, "chatgpt")

if not status then
  return
end

local home = os.getenv("HOME")
chatgpt.setup({
  openai_params = {
    model = "",
    max_tokens = 2048,
    top_p = 0.8,
    temperature = 0.9
  },
  actions_paths = {
    home .. "/.dotfiles/vim/lua/configs/chatgpt_actions.json"
  },
  api_host_cmd = "echo -n https://inference.friendli.ai/mixtral-8x7b-instruct-v0-1",
})
