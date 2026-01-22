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

-- C言語のコメントの色を白に設定
vim.cmd([[highlight Comment ctermfg=White guifg=#808080]])
