set list
set listchars=tab:\│\ 
set fillchars=vert:│
" highlight VertSplit ctermbg=8 ctermfg=8 cterm=none
" highlight MatchParen ctermfg=12 ctermbg=none cterm=reverse
" highlight Whitespace ctermfg=8 ctermbg=0
" highlight NonText ctermfg=7
" highlight CursorLineNr ctermfg=15 cterm=bold
" highlight LineNr ctermfg=4
" highlight Folded cterm=italic ctermbg=0
" highlight FoldColumn ctermbg=0
" highlight Conceal ctermfg=15 ctermbg=0
" highlight ErrorMsg ctermfg=9
" highlight cssNoise ctermfg=4
" 
" highlight htmlItalic cterm=italic
" highlight mkdHeading ctermfg=4
" highlight htmlH1 cterm=bold
" highlight htmlH2 cterm=bold
" highlight htmlH3 cterm=bold
" highlight htmlH4 cterm=bold
" highlight htmlH5 cterm=bold
" highlight htmlH6 cterm=bold
" 
" "set cursorline cursorcolumn
" highlight CursorLine ctermbg=8 cterm=none
" 
" highlight DiffAdd ctermbg=22 ctermfg=7
" highlight DiffText ctermbg=0 ctermfg=7
" highlight DiffDelete ctermbg=52 ctermfg=7
" highlight DiffChange ctermbg=61 ctermfg=7
" 
" highlight TagbarSignature ctermfg=3
" highlight GitGutterAddDefault ctermfg=12
" 
" highlight IncSearch ctermbg=0 ctermfg=14
" highlight Search ctermbg=5 ctermfg=0
" 
" highlight CocFloating ctermbg=8
" highlight CocHighlightText cterm=reverse
" 
" highlight ColorColumn ctermfg=none ctermbg=none cterm=underline,bold

highlight whitespace gui=bold

function! HLFlicker (blinktime)
	set cursorline
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	set nocursorline
	redraw
endfunction

if !&diff
	augroup CursorLine
		autocmd!
		autocmd VimEnter * setlocal cursorline
		autocmd WinEnter * setlocal cursorline
		autocmd BufWinEnter * setlocal cursorline
		autocmd FocusGained * setlocal cursorline
		autocmd WinLeave * setlocal nocursorline
		autocmd BufWinLeave * setlocal nocursorline
		autocmd FocusLost * setlocal nocursorline
		autocmd CompleteChanged * setlocal cursorline
		autocmd CompleteDone * setlocal cursorline
		autocmd InsertEnter * setlocal nocursorline
		autocmd InsertLeave * setlocal cursorline
	augroup END
else
	set cursorline
	highlight cursorline cterm=none gui=none
endif

augroup LineLengths
	autocmd Filetype cpp call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
	autocmd Filetype rust call matchadd('ColorColumn', '\%81v.\{0,19\}', 100)
augroup END
