-- 80文字で自動改行（ハードラップ）を有効にする
vim.opt_local.textwidth = 80

-- スペルチェックを有効にする
-- ltex-lsを使うので無効にする
vim.opt_local.spell = true

-- スペルチェックの言語を英語（と必要なら日本語の干渉を防ぐ設定）にする
vim.opt_local.spelllang = { "en_us" }

-- 改行の挙動を調整（t: textwidthでの自動改行、c: コメント内での自動改行）
vim.opt_local.formatoptions = "tcqjn"
