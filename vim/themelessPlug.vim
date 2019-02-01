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

Plug 'jreybert/vimagit'

Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'

Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'

Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/nextval'
Plug 'vim-scripts/autocomplpop'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'
Plug 'gko/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'patstockwell/vim-monokai-tasty'

Plug 'vim-syntastic/syntastic'

" Initialize plugin system
call plug#end()
"====================================================
"}}}
"====================================================

"====================================================
"{{{ PLUGIN BINDINGS
"====================================================
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

autocmd Filetype fzf tmap <silent> <C-g> <Esc>:q<CR>
autocmd Filetype fzf tmap <silent> <C-d> <Esc>:q<CR>
autocmd Filetype fzf tmap <silent> <C-c> <Esc>:q<CR>

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fh :Files ~/<CR>
nnoremap <silent> <leader>gg :GGrep<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>rg :Rg<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fal :Lines<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>fH :Helptags<CR>

nnoremap <leader>mg :Magit<CR>
nnoremap <leader>mo :MagitOnly<CR>
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
"{{{COLORSCHEMES
"====================================================
let g:solarized_contrast = 0
let g:solarized_italic = 0
let g:solarized_underline = 0
let g:airline_theme = 'monokai_tasty'
let g:airline_solarized_bg = 'dark'
let g:solarized_termtrans = 1
colorscheme vim-monokai-tasty
set background=dark
"====================================================
"}}}
"====================================================
