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
		-- winopts = {
		--	treesitter = false,
		-- },

		-- 描画崩れを防ぐためのウィンドウ表示設定
		-- floating_window_scaling_factor = 0.85,
		-- yazi_floating_window_winblend = 0,

		-- フローティングウィンドウの表示カスタマイズ（好みに応じて変更可能）
		floating_window_styling = {
			border = "rounded",
		},
		-- ターミナル描画の競合を回避するオプション
		-- set_keymappings_when_components_ready = true,
	},
}
