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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomasr/molokai'

Plugin 'valloric/youcompleteme'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leafgarland/typescript-vim'

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
set relativenumber      " Show line numbers around as relative

set incsearch           " Search as characters are entered
set hlsearch            " Highlight matches
set showmatch           " Highlight matching [{()}]
set showcmd             " Show command in bottom bar
" set cursorline          " highlight current line
"
set backupcopy=yes

" turn off search highlight with leader-,
nnoremap <leader>, :nohlsearch<CR>

" Cycle through buffers 
nnoremap <leader>j :bp<CR>
nnoremap <leader>k :bn<CR>

nnoremap <leader>dj :bp\|bd #<CR>
nnoremap <leader>dk :bn\|bd #<CR>

" Set up the extra directories outside of the project directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//


"Set ignored files
set wildignore+=*.meta,*.prefab,*.exe,*.zip,*.animation,*/node_modules/*,*\\node_modules\\*
" Ignore the files in NerdTree as well
let g:NERDTreeIgnore=['node_modules']

"--------------------Plugin configuration---------------
"
"For airline, so it shows all buffers in the top bar when there is only one
"tab open
let g:airline#extensions#tabline#enabled = 1

"For NERDTree, opens the tree
nnoremap <leader>t :NERDTree<CR>
nnoremap <leader>T :NERDTree ~/<CR>

" Mappings for vimgrep next, previous, file next and file previous
nnoremap <leader>n :cn<CR>
nnoremap <leader>p :cp<CR>

nnoremap <leader>fn :cnf<CR>
nnoremap <leader>fp :cnp<CR>


"For Ctrl.P
nnoremap <c-P> :CtrlPBuffer<CR>
" Ignore gitignored files
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Just open ctrl p in cwd, i.e. the folder in which the vim command is called from 
let g:ctrlp_working_path_mode = ''

" For Indent guides
set ts=2 sw=2 et
set background=dark

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"Set the theme
colorscheme molokai

" Set movement keys to move by virtual line, i.e. get around wrapped lines

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

nnoremap $ g$
nnoremap 0 g0
vnoremap $ g$
vnoremap 0 g0

" Syntax highlighting for react files without .jsx extension
let g:jsx_ext_required = 0

" Automatic linting with Standard for js files
let g:syntastic_javascript_checkers = ["standard"]

" Set the filetype for gyp to json file
au BufRead,BufNewFile *.gyp set filetype=json

" Set python indentation to 2 characters
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
