"
"             ________)            
"            (, /                  
"              /___, _  __   _     
"           ) /     (_(_/ (_(__(_/_
"          (_/                .-/  
"                            (_/   
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"Disable GitGutter bindings
let g:gitgutter_map_keys = 0

"Pretty Indent Line
let g:indentLine_char = '|'

" Map ESC to exit terminal mode
tnoremap <Esc> <C-\><C-n>

"Changes the Colorscheme to better suit a dark background
set bg=dark

"Airline Fixes
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"Startify Config
let g:startify_files_number = 5
let g:startify_custom_header = [
            \ '              __    __) _____ __     __)',
            \ '             (, )  /   (, /  (, /|  /|  ',
            \ '                | /      /     / | / |  ',
            \ '                |/   ___/__ ) /  |/  |_ ',
            \ '                |  (__ /   (_/   |       ',
            \ ]
