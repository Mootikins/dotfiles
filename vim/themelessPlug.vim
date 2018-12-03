"      
"       __    __     __     __   __     __    
"      /\ "-./  \   /\ \   /\ "-.\ \   /\ \   
"      \ \ \-./\ \  \ \ \  \ \ \-.  \  \ \ \  
"       \ \_\ \ \_\  \ \_\  \ \_\\"\_\  \ \_\ 
"        \/_/  \/_/   \/_/   \/_/ \/_/   \/_/ 
"                                             
"      
"====================================================
"{{{PLUGINS
"====================================================
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'junegunn/vim-plug'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'

Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/nextval'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'jreybert/vimagit'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'ying17zi/vim-live-latex-preview', { 'for': 'tex' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'gko/vim-coloresque'

Plug 'vim-syntastic/syntastic'

" Initialize plugin system
call plug#end()
"====================================================
"}}}
"====================================================

"====================================================
"{{{FZF BINDINGS
"====================================================
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fh :Files ~/<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>rg :Rg<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fal :Lines<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>fH :Helptags<CR>
"====================================================
"}}}
"====================================================

"====================================================
"{{{ SYNTASTIC CHANGES
"====================================================
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "passive_filetypes": ["asm"] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"====================================================
"}}}
"====================================================

"====================================================
"{{{SOLARIZED
"====================================================
let g:solarized_contrast = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark
"====================================================
"}}}
"====================================================
