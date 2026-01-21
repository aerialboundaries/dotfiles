-- init.lua

-- ===========================
-- 🧠 基本設定読み込み
-- ===========================
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- ===========================
-- 📦 lazy.nvim 初期化
-- ===========================
require("config.lazy")

-- ===========================
-- Float Clang error message
-- -- 診断情報（エラーや警告）の表示設定
vim.diagnostic.config({
	virtual_text = true, -- 行の横にメッセージを表示（不要ならfalse）
	signs = true, -- 行番号の横にアイコンを表示
	underline = true, -- エラー箇所に下線を表示
	update_in_insert = false, -- 挿入モード中は更新しない（入力の邪魔にならないように）
	severity_sort = true, -- エラーを優先的に表示
})

-- カーソルを保持したときに浮遊ウィンドウ（ポップアップ）を表示する設定
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
			border = "rounded", -- 枠線を角丸にする（お好みで 'single', 'double'）
			source = "always", -- clangd などのソース名を表示
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

-- ポップアップが出るまでの時間（ミリ秒）デフォルトは4000msなので短くするのがおすすめ
vim.o.updatetime = 300
