-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- lua/config/autocmds.lua

-- tmuxの他のペインにカレントディレクトリを同期する関数を定義
local function tmux_sync_cwd()
	-- 環境変数TMUXが存在するかどうかを確認
	if vim.env.TMUX then
		-- nvimが移動したカレントディレクトリを取得し、シェルで安全に実行できるようにエスケープ
		-- vim.fn.getcwd() は現在ディレクトリを文字列で返す
		-- string.gsub() を使ってエスケープする
		local current_dir = vim.fn.getcwd()

		-- tmux send-keysコマンドを構築
		-- target-pane:!# は現在のウィンドウの他のすべてのペインを指す
		local cmd = string.format('tmux send-keys -t "target-pane:!#" "cd %s" Enter', current_dir)

		-- コマンドを実行
		-- cmdをシェルに渡す
		os.execute(cmd)
	end
end

-- DirChangedイベント（:cd など）が発生したら関数を実行するためのAutoCommandを設定
vim.api.nvim_create_autocmd("DirChanged", {
	group = vim.api.nvim_create_augroup("TmuxCwdSync", { clear = true }), -- グループを作成し、以前の設定をクリア
	pattern = "*", -- すべてのファイルタイプで実行
	callback = tmux_sync_cwd, -- 定義した関数をコールバックとして指定
	desc = "Sync CWD to other tmux panes when nvim directory changes",
})

-- nvim内でファイルを保存した際にも実行したい場合は、FileWritePostイベントも追加します
vim.api.nvim_create_autocmd("FileWritePost", {
	group = vim.api.nvim_create_augroup("TmuxCwdSync", { clear = false }),
	pattern = "*",
	callback = tmux_sync_cwd,
	desc = "Sync CWD to other tmux panes after file write",
})
