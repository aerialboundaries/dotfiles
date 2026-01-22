vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- =======================================================
-- Telescope キーバインドの追加
-- Telescope を使用するには、事前にプラグインのインストールが必要です。
-- =======================================================

-- ローカルファイル検索 (最もよく使う機能)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- 最近開いたファイル
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })

-- 現在開いているバッファ (ファイル) の一覧
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

-- リポジトリ内の文字列検索 (Live Grep)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep (Text Search)" })

-- Vim/Neovim のヘルプタグ検索
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

-- ========================================================
