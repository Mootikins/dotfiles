set fillchars=vert:│
highlight VertSplit ctermbg=8 ctermfg=8 cterm=none
highlight MatchParen ctermfg=12 ctermbg=none cterm=reverse
highlight Whitespace ctermfg=8 ctermbg=0
highlight NonText ctermfg=7
highlight CursorLineNr ctermfg=15 cterm=bold
highlight LineNr ctermfg=4
highlight Folded cterm=italic ctermbg=0
highlight FoldColumn ctermbg=0
highlight Conceal ctermfg=15 ctermbg=0
highlight htmlItalic cterm=italic

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

highlight DiffAdd ctermbg=22 ctermfg=7
highlight DiffText ctermbg=0 ctermfg=7
highlight DiffDelete ctermbg=52 ctermfg=7
highlight DiffChange ctermbg=61 ctermfg=7

highlight TagbarSignature ctermfg=3
highlight GitGutterAddDefault ctermfg=12

highlight IncSearch ctermbg=0 ctermfg=14
highlight Search ctermbg=5 ctermfg=0

if has ('nvim')
	set list
	set listchars=tab:\|\ 

	highlight CocFloating ctermbg=8
	highlight CocHighlightText cterm=reverse

	highlight Sneak cterm=reverse ctermfg=none ctermbg=none
	highlight SneakLabel cterm=reverse ctermfg=none ctermbg=none
	highlight SneakScope cterm=none ctermbg=8 ctermfg=none
else
	highlight signcolumn ctermbg=0
end

highlight ColorColumn ctermfg=none ctermbg=none cterm=underline

augroup LineLengths
	autocmd Filetype cpp call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
	autocmd Filetype rust call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
augroup END
