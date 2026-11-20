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

-- fold codes
vim.wo.foldmethod = "indent"
vim.wo.foldlevel = 99

-- blink cursor
-- vim.opt.guicursor = "n-v-c:block-blinkon1,i-ci-ve:ver25-blinkon1,r-cr:hor20,o:hor50"

-- ウィンドウリサイズ時に自動で全分割ウィンドウを等幅にする
vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

-- 対応する括弧のハイライト色変更
local set_hl = vim.api.nvim_set_hl

local function set_custom_highlights()
	set_hl(0, "MatchParen", {
		fg = "#70D6FF",
		bg = "NONE",
		bold = true,
	})
end

set_custom_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_custom_highlights,
})

-- OSC52を使ってyankしたものをwinに貼り付けられるように
vim.opt.clipboard = "unnamedplus"

if os.getenv("SSH_TTY") ~= nil or os.getenv("SSH_CONNECTION") ~= nil then
	local function osc52_copy(lines, _)
		local text = table.concat(lines, "\n")
		local b64 = vim.base64.encode(text)
		local seq = "\027]52;c;" .. b64 .. "\007"
		local term = vim.env.TERM or ""
		if vim.env.TMUX ~= nil or term:match("^tmux") or term:match("^screen") then
			seq = "\027Ptmux;\027" .. seq .. "\027\\"
		end
		vim.api.nvim_chan_send(vim.v.stderr, seq)
	end

	vim.g.clipboard = {
		name = "OSC 52 tmux-safe",
		copy = {
			["+"] = osc52_copy,
			["*"] = osc52_copy,
		},
		paste = {
			["+"] = require("vim.ui.clipboard.osc52").paste("+"),
			["*"] = require("vim.ui.clipboard.osc52").paste("*"),
		},
	}
end
