return {
	"robitx/gp.nvim",
	config = function()
		local conf = {
			providers = {
				-- プロバイダ名を gemini に変更し、OpenAI互換のエンドポイントを指定します
				gemini = {
					endpoint = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
					secret = os.getenv("GEMINI_API_KEY"),
				},
			},
			-- デフォルトで起動するエージェント名を指定します
			default_command_agent = "Gemini",
			default_chat_agent = "Gemini",
			agents = {
				{
					name = "Gemini",
					chat = true,
					command = true,
					provider = "gemini",
					model = { model = "gemini-3.1-flash-lite" },
					system_prompt = "You are a helpful AI coding assistant.",
				},
			},
		}
		require("gp").setup(conf)
	end,
}
