return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		-- \y で現在のファイルの場所を開いてYaziを起動する設定
		{
			"<leader>y",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		-- \cw で現在のワーキングディレクトリを対象にYaziを起動する設定
		{
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",

			desc = "Open yazi at the current working directory",
		},
	},
	opts = {

		-- Yaziを閉じるときに、最後に選択していたディレクトリにnvimのカレントディレクトリを同期させるか
		-- (trueにすると、Yaziで移動した場所にnvimの作業ディレクトリが自動で切り替わります)
		update_cwd = true,

		-- フローティングウィンドウの表示カスタマイズ（好みに応じて変更可能）
		floating_window_styling = {
			border = "rounded",
		},
	},
}
