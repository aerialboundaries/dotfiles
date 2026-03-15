return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- 0.11 以降の推奨される新しい書き方
			-- 今までの require("lspconfig").clangd.setup({}) の代わりになります

			-- システムの clangd を使う設定
			vim.lsp.config("clangd", {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			})

			-- 設定を有効化（アタッチ）
			vim.lsp.enable("clangd")

			-- 他のサーバー（lua_lsなど）も同様に設定できます
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end,
	},
}
