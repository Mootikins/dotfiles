"
"             ________)            
"            (, /                  
"              /___, _  __   _     
"           ) /     (_(_/ (_(__(_/_
"          (_/                .-/  
"                            (_/   
"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'
Plug 'mootikins/vim-snippets'
Plug 'sirver/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'dylanaraps/wal.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Disable GitGutter bindings
let g:gitgutter_map_keys = 0

"Colorscheme and General Themes
colorscheme wal

"Pretty Indent Line
let g:indentLine_char = '|'

"Changes the Colorscheme to better suit a dark background
set bg=dark

"Airline Fixes
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'wal'

"Startify Config
let g:startify_files_number = 5
let g:startify_custom_header = [
            \ '              __    __) _____ __     __)',
            \ '             (, )  /   (, /  (, /|  /|  ',
            \ '                | /      /     / | / |  ',
            \ '                |/   ___/__ ) /  |/  |_ ',
            \ '                |  (__ /   (_/   |       ',
            \ ]
