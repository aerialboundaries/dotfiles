return {
  -- Neovim 0.10 以降は nvim-lspconfig 不要！
  -- 組み込みの vim.lsp.config API を使用
  "neovim/nvim-lspconfig",  -- ※削除してもOK（依存プラグインで使う場合は残してもよい）
  enabled = false,  -- lazy.nvim に読み込ませないように
}

