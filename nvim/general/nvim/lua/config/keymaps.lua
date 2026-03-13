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
-- インサートモードで HJKL の位置を使って移動する設定
-- Ctrl + h はバックスペースではなく「左移動」として機能させます
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = true })

-- もし Ctrl + h を移動に使った場合、バックスペースはどうするか？

-- 代わりに Ctrl + d (Delete) や Ctrl + w (単語削除) を活用するのが一般的です
vim.keymap.set("i", "<C-d>", "<BS>", { noremap = true, silent = true })

-- インサートモードを抜けるための代替（Escが遠い場合）
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
