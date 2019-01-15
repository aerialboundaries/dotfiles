set tabstop=2
set shiftwidth=2
set noexpandtab
set autoindent
set nocompatible
filetype on
filetype indent on
filetype plugin on
set number
set ignorecase
set smartcase
set backspace=indent,eol,start
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set number
set ruler
set nolist
set wrap
set laststatus=2
set nobackup
set noswapfile
syntax enable
set background=dark
let loaded_matchparen = 1
set t_Co=256
set clipboard+=unnamed
set cursorline

let g:sh_indent_case_labels = 1 "Indent of case in sh for .vim/indent/sh.vim

" Vim-Plug Setting
call plug#begin('~/.vim/plugged')

" Plug 'prettier/prettier'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'tyru/caw.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/neocomplcache.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Vim起動時にneocompleteを有効にする
    let g:neocomplcache_enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplcache_enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplcache_min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplcache_enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplcache_auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplcache#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
 
"Color schemes list
Plug 'altercation/vim-colors-solarized' " solarized
Plug 'croaker/mustang-vim'              " mustang
Plug 'jeffreyiacono/vim-colors-wombat'  " wombat
Plug 'nanotech/jellybeans.vim'          " jellybeans
Plug 'vim-scripts/Lucius'               " lucius
Plug 'vim-scripts/Zenburn'              " zenburn
Plug 'mrkn/mrkn256.vim'                 " mrkn256
Plug 'jpo/vim-railscasts-theme'         " railscasts
Plug 'therubymug/vim-pyte'              " pyte
Plug 'tomasr/molokai'                   " molokai
Plug 'chriskempson/vim-tomorrow-theme'  " tomorrow night
Plug 'vim-scripts/twilight'             " twilight
Plug 'w0ng/vim-hybrid'                  " hybrid
Plug 'freeo/vim-kalisi'                 " kalisi
Plug 'morhetz/gruvbox'                  " gruvbox
Plug 'toupeira/vim-desertink'           " desertink
Plug 'sjl/badwolf'                      " badwolf
Plug 'itchyny/landscape.vim'            " landscape
Plug 'joshdick/onedark.vim'             " onedark in atom
Plug 'gosukiwi/vim-atom-dark'           " atom-dark
call plug#end()

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
 let g:solarized_italic=0    "default value is 1
 let g:solarized_contrast="high"    "default value is normal
" let g:solarized_visibility="high"    "default value is normal
 colorscheme solarized
" ------------------------------------------------------------------
