-- init.lua (packer.nvim 用)

-- packer.nvim がインストールされていなければ自動でインストール
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

-- 基本オプション設定
local set = vim.o
set.t_Co = 256
set.autoread = true
set.background = "dark"
set.backspace = "indent,eol,start"
set.cursorline = true
set.expandtab = true
set.hidden = true
set.hlsearch = true
set.ignorecase = true
set.incsearch = true
set.laststatus = 2
set.backup = false
set.swapfile = false
set.number = true
set.ruler = true
set.shiftwidth = 2
set.showcmd = true
set.showmatch = true
set.smartcase = true
set.smartindent = true
set.tabstop = 2
set.virtualedit = "onemore"
set.wildmode = "list:longest"
set.wrapscan = true

-- キーマッピング
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { noremap = true, silent = true })

-- シンタックス有効
vim.cmd("syntax on")

-- Packer 設定
require('packer').startup(function(use)
  -- Packer 自身
  use 'wbthomason/packer.nvim'

  -- プラグイン一覧
  use 'w0rp/ale'
  use 'pangloss/vim-javascript'
  use 'mattn/emmet-vim'
  use 'tpope/vim-surround'
  use 'tyru/caw.vim'
  use 'scrooloose/nerdtree'
  
  -- deoplete.nvim はビルドコマンド付き
  use {
    'Shougo/deoplete.nvim',
    run = ':UpdateRemotePlugins'
  }
end)

-- deoplete を有効化
vim.g["deoplete#enable_at_startup"] = 1

-- 透明背景設定
vim.cmd [[
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none
]]

-- カラー設定（必要に応じて有効化）
-- vim.cmd("colorscheme solarized")
-- vim.cmd("colorscheme molokai")

