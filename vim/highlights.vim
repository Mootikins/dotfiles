set fillchars=vert:│
highlight VertSplit ctermbg=black ctermfg=white cterm=none
highlight NonText ctermfg=8
highlight CursorLineNr ctermfg=9
highlight LineNr ctermfg=4

"set cursorline cursorcolumn
highlight CursorLine ctermbg=8 ctermfg=15 cterm=none

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

highlight DiffAdd ctermbg=22 ctermfg=7
highlight DiffText ctermbg=0 ctermfg=7
highlight DiffDelete ctermbg=52 ctermfg=7
highlight DiffChange ctermbg=61 ctermfg=7

highlight IncSearch ctermbg=0 ctermfg=6
highlight Search ctermbg=5 ctermfg=0

if has ('nvim')
	set list
end
set listchars=tab:\|\ 

"Highlight columns 81 and 101 on lines with that many characters
autocmd Filetype cpp call matchadd('ColorColumn', '\%81v', 100)
autocmd Filetype cpp call matchadd('ColorColumn', '\%101v', 100)
