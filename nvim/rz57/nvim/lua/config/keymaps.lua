vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- My config
-- ★ ここからTelescopeのキーマップを追加 ★

-- 1. ファイル関連の検索
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" }) -- 全ファイルの検索
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Git Files" }) -- Git管理下のファイルのみ検索
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" }) -- 最近開いたファイルの履歴検索
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" }) -- 現在開いているバッファの検索

-- 2. 文字列検索 (Grep)
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep (Text Search)" }) -- ワークスペース全体からの文字列検索
vim.keymap.set("n", "<leader>fS", "<cmd>Telescope grep_string<cr>", { desc = "Grep Word Under Cursor" }) -- カーソル下の単語を検索

-- 3. 設定・ヘルプ関連
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" }) -- ヘルプドキュメントの検索
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps" }) -- 現在のキーマップの検索
-- ここまで
--
