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
			-- ここにカスタムフックとキーマップを追加
			hooks = {
				Explain = function(gp, params)
					local template =
						"以下のコードを日本語で詳しく解説してください。\n\n```{{filetype}}\n{{selection}}\n```"
					local agent = gp.get_command_agent()
					gp.Prompt(params, gp.Target.popup, agent, template)
				end,
			},
		}
		require("gp").setup(conf)
	end,
}
