set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomasr/molokai'

Plugin 'valloric/youcompleteme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Set the Cursor to a block for windows
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"Map jk to esc
inoremap jk <ESC>
vnoremap jk <ESC>
let mapleader="\<Space>"
syntax on

"Set the formatting options for vim
set encoding=utf8
set tabstop=4
set shiftwidth=4
set expandtab           " Tabs are spaces
set number              " Show line numbers

set incsearch           " Search as characters are entered
set hlsearch            " Highlight matches
set showmatch           " Highlight matching [{()}]
set showcmd             " Show command in bottom bar
" set cursorline          " highlight current line

" turn off search highlight with leader-,
nnoremap <leader>, :nohlsearch<CR>

" Cycle through tabs 
nnoremap <leader>j :tabp<CR>
nnoremap <leader>k :tabn<CR>

"set noswapfile
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//


"Set ignored files
set wildignore+=*.meta,*.prefab,*.exe,*.zip,*.animation

" For when I fuck up and write :W
:command W w

"--------------------Plugin configuration---------------
"
"For airline, so it shows all buffers in the top bar when there is only one
"tab open
let g:airline#extensions#tabline#enabled = 1

"For NERDTree, opens the tree
nnoremap <leader>t :NERDTree<CR>
nnoremap <leader>T :NERDTree ~/<CR>

"For Ctrl.P
nnoremap <c-P> :CtrlPBuffer<CR>

" For Indent guides
set ts=4 sw=4 et
set background=dark

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"Set the theme
colorscheme molokai
