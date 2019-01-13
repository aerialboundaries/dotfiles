set autoread  "Reload if the file is modified
set background=dark
set backspace=indent,eol,start  "To delete these with BS key
set cursorline  "Highlight the row on the cursor
set expandtab  "Enable soft tab (space instead of tab)
set hidden  "Enable to open other file while the buffer is being edited
set hlsearch  "Highlight the searched word
set ignorecase  "If searched with lower case, ignore the case
set incsearch  "Incremental search
set laststatus=2  "Always show status line
set nobackup  "Do not create backup file before overwriting
set noswapfile  "No swap file
set number  "Set row number
set ruler  "Show ruler
set shiftwidth=2  "indent width in auto indent
set showcmd  "Show the command being input
set showmatch  "Show the corresponding parenthesis
set smartcase  "If searched with upper case, distiguish upper case
set smartindent  "Smart indent
set tabstop=2  "Set width of tab in the file
set virtualedit=onemore  "Enable to move the 1 char after line end
set wildmode=list:longest  "Complement command line
set wrapscan  "Go back to the top after searching to the last
nmap <Esc><Esc> :nohlsearch<CR><Esc>  "Disenable highlight with ESC's
syntax on

"Vim-plug
call plug#begin()
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'  "solarized
Plug 'tomasr/molokai'  "molokai
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
call plug#end()

"Solarized color scheme setting
colorscheme solarized

"Molokai color scheme setting
"colorscheme molokai

"Transparent background
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 
