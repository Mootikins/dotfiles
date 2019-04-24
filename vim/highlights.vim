set fillchars=vert:│
highlight VertSplit ctermbg=0 ctermfg=15 cterm=none
highlight MatchParen ctermfg=12 ctermbg=none cterm=reverse
highlight NonText ctermfg=8
highlight CursorLineNr ctermfg=15
highlight LineNr ctermfg=4
highlight Folded cterm=italic

"set cursorline cursorcolumn
highlight CursorLine ctermbg=8 cterm=none

augroup CursorLine
    autocmd!
		autocmd VimEnter * setlocal cursorline
		autocmd WinEnter * setlocal cursorline
		autocmd BufWinEnter * setlocal cursorline
		autocmd FocusGained * setlocal cursorline
		autocmd WinLeave * setlocal nocursorline
		autocmd BufWinLeave * setlocal nocursorline
		autocmd FocusLost * setlocal nocursorline
augroup END

highlight ColorColumn ctermfg=none ctermbg=none cterm=underline

highlight DiffAdd ctermbg=22 ctermfg=7
highlight DiffText ctermbg=0 ctermfg=7
highlight DiffDelete ctermbg=52 ctermfg=7
highlight DiffChange ctermbg=61 ctermfg=7

highlight IncSearch ctermbg=0 ctermfg=14
highlight Search ctermbg=5 ctermfg=0

if has ('nvim')
	set list
	set listchars=tab:\|\ 
end

augroup LineLengths
	autocmd Filetype cpp call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
	autocmd Filetype rust call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
augroup END
