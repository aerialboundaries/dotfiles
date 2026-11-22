-- =============================================================================
-- Markdown (English Handover Manual) Buffer-Local Settings
-- =============================================================================

-- 1. 折り返し（ハードラップ）設定
-- 80文字で折り返しつつ、テーブル行やコードブロック・長いリンクは自動改行で壊さない
-- vim.opt_local.textwidth = 80 テーブルがおかしくなるのではずす
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- 画面表示の折り返しも単語の途中で切らない

-- formatoptions の内訳:
--   c: コメント内の自動改行
--   q: `gq` コマンドでの手動段落整形を許可
--   j: 結合時に不要なコメント記号を除去
--   n: 番号付きリストのインデントを維持して折り返し
--   l: すでに長い行（URLやテーブル行など）は入力中に自動分割しない
-- ※ 入力中の自動改行 `t` は、表（|...|）やファイルパスを破壊しやすいので外し、
--    普通の英文段落を揃えたいときだけ `gqip` で整形する運用が安全です。
vim.opt_local.formatoptions = "cqjnl"

-- 2. スペルチェック設定
-- ltex-ls / ltex_plus を有効化している場合は Neovim 標準の spell と重複するため false にする
-- （未導入・未有効化の間は true にしておくと基本の英単語スペルミスを拾えます）
local has_ltex = (#vim.lsp.get_clients({ bufnr = 0, name = "ltex" }) > 0)
	or (#vim.lsp.get_clients({ bufnr = 0, name = "ltex_plus" }) > 0)

vim.opt_local.spell = not has_ltex
vim.opt_local.spelllang = { "en_us" }

-- 3. Markdown / 引継書向けの視認性・インデント調整
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.conceallevel = 0 -- リンクパス（./files/...）や LaTeX コマンドを隠さずそのまま表示
