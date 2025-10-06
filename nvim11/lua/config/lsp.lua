-- ~/.config/nvim/lua/config/lsp.lua
-- Neovim 0.10+ の組み込み LSP 設定例

-- ルートディレクトリを探すヘルパー関数
local function find_root(markers)
  local util = vim.fs
  return function(fname)
    return util.dirname(util.find(fname, markers, { upward = true }))
  end
end

-- Python: Pyright サーバー設定
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = find_root({ 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' }),
  settings = {},
})

-- ファイルタイプごとに自動で LSP を起動
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.lsp.start({
      name = 'pyright',
      cmd = { 'pyright-langserver', '--stdio' },
      root_dir = find_root({ 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' })(vim.api.nvim_buf_get_name(0)),
    })
  end,
})

