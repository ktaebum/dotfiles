local status, avante = pcall(require, "avante")

if not status then
  return
end

avante.setup({
  provider = "friendli",
  auto_suggestions_provider = "friendli",
  vendors = {
    friendli = {
      __inherited_from = "openai",
      endpoint = "https://api.friendli.ai/serverless/v1",
      api_key_name = "FRIENDLI_API_KEY",
      model = "meta-llama-3.3-70b-instruct"
    }
  }
})
