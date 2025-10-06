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

-- init.lua

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy.nvim setup
require("config.lazy")

-- LSPをネイティブ構成で読み込む
require("config.lsp")

