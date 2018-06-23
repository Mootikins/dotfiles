"
"            __    __) _____ __     __) 
"           (, )  /   (, /  (, /|  /|   
"              | /      /     / | / |   
"              |/   ___/__ ) /  |/  |_  
"              |  (__ /   (_/   '       
"                            
"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'mhinz/vim-startify'
Plug 'mootikins/vim-snippets'
Plug 'sirver/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'dylanaraps/wal.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

set number relativenumber
set shiftwidth=4 softtabstop=4 expandtab "Use Spaces Instead of Tabs
set showcmd
set mouse=a
set ignorecase smartcase
set fillchars+=vert:\ 

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Change Nerd Tree Directory Symbols
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

"Disable GitGutter bindings
let g:gitgutter_map_keys = 0

"Turn On OmniComplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"Colorscheme and General Themes
colorscheme wal

"Pretty Indent Line
let g:indentLine_char = '|'

"Changes the Colorscheme to better suit a dark background
set bg=dark

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'wal'

"GENERAL REMAPS
let mapleader = " "

"Leave Insert Mode
inoremap jk <esc>
inoremap kj <Esc>

"Create Splits
nnoremap <leader>\ :vnew<CR>
nnoremap <leader>- :new<CR>

"Open NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

"Open Splits to Right and Bottom
set splitright
set splitbelow

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
nnoremap <A-S-h> :vertical resize +5<CR>
nnoremap <A-S-j> :resize -5<CR>
nnoremap <A-S-k> :resize +5<CR>
nnoremap <A-S-l> :vertical resize -5<CR>

"Snippets

"Snippet Find and Change
nnoremap <leader><BS> ?<++><CR>ca<
nnoremap <leader><Tab> <Esc>/<++><CR>ca<

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"Startify Config
let g:startify_files_number = 5
let g:startify_custom_header = [
            \ '              __    __) _____ __     __)',
            \ '             (, )  /   (, /  (, /|  /|  ',
            \ '                | /      /     / | / |  ',
            \ '                |/   ___/__ ) /  |/  |_ ',
            \ '                |  (__ /   (_/   |       ',
            \ ]
