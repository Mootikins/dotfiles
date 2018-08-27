"           __________  ____  ______
"          / ____/ __ \/ __ \/ ____/
"         / /   / / / / /_/ / __/   
"        / /___/ /_/ / _, _/ /___   
"        \____/\____/_/ |_/_____/   
"                           
"
"
set number relativenumber
set shiftwidth=4 softtabstop=4 expandtab "Use Spaces Instead of Tabs
set showcmd
set mouse=a
set ignorecase smartcase
set fillchars+=vert:\ 

"Change Nerd Tree Directory Symbols
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

"Turn On OmniComplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"GENERAL REMAPS
let mapleader = " "

"Leave Insert Mode
inoremap jk <esc>
inoremap kj <Esc>

"Create Splits
nnoremap <leader>\ :vnew<CR>
nnoremap <leader>- :new<CR>

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
nnoremap <C-S-h> :vertical resize +5<CR>
nnoremap <C-S-j> :resize -5<CR>
nnoremap <C-S-k> :resize +5<CR>
nnoremap <C-S-l> :vertical resize -5<CR>

"Tabs
nnoremap <leader><C-n> :tabNext<CR>
nnoremap <leader><C-p> :tablast<CR>
nnoremap <leader><C-t> :tabnew<CR>
nnoremap <leader><C-w> :tabclose<CR>
