" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'scrooloose/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

set showcmd
set mouse=a
set ignorecase
set smartcase

"Colorscheme and General Themes
colorscheme wal

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'wal'

"GENERAL REMAPS
let mapleader = " "

"Leave Insert Mode
inoremap jk <esc>
inoremap kj <Esc>

"Create Splits
nnoremap <leader>\ :vsplit<CR>
nnoremap <leader>- :split<CR>

"Open NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

"Split Selection, Directional
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"Split Movement
nnoremap <leader>H <C-w>H
nnoremap <leader>J <C-w>J
nnoremap <leader>K <C-w>K
nnoremap <leader>L <C-w>L

"Split Resizing
nnoremap <leader><C-h> :vertical resize -5<CR>
nnoremap <leader><C-j> :resize -5<CR>
nnoremap <leader><C-k> :resize +5<CR>
nnoremap <leader><C-l> :vertical resize +5<CR>

"Snippets

"Snippet Find and Change
nnoremap <leader><BS> ?<++><CR>ca<
nnoremap <leader><Tab> <Esc>/<++><CR>ca<

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set number relativenumber
