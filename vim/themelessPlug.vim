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
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

" Initialize plugin system
call plug#end()
"====================================================
"}}}
"====================================================

"====================================================
"{{{FZF BINDINGS
"====================================================
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :Files ~/<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fal :BLines<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>ht :Helptags<CR>
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
