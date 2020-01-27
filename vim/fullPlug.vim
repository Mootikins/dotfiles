"    
"          ___           ___       ___           ___     
"         /\  \         /\__\     /\__\         /\  \    
"        /::\  \       /:/  /    /:/  /        /::\  \   
"       /:/\:\  \     /:/  /    /:/  /        /:/\:\  \  
"      /::\~\:\  \   /:/  /    /:/  /  ___   /:/  \:\  \ 
"     /:/\:\ \:\__\ /:/__/    /:/__/  /\__\ /:/__/_\:\__\
"     \/__\:\/:/  / \:\  \    \:\  \ /:/  / \:\  /\ \/__/
"          \::/  /   \:\  \    \:\  /:/  /   \:\ \:\__\  
"           \/__/     \:\  \    \:\/:/  /     \:\/:/  /  
"                      \:\__\    \::/  /       \::/  /   
"                       \/__/     \/__/         \/__/    
"    
"===============================================================
"{{{ PLUGINS
"===============================================================
call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'

Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'simnalamburt/vim-mundo'
Plug 'majutsushi/tagbar'

Plug 'mattn/emmet-vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'

Plug 'preservim/nerdcommenter'

Plug 'wincent/terminus'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'gko/vim-coloresque'

Plug 'yggdroot/indentline'

Plug 'dylanaraps/wal.vim'
Plug 'deviantfero/wpgtk.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'segeljakt/vim-silicon'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'kkoomen/vim-doge'

Plug 'jpalardy/vim-slime'

" Initialize plugin system
call plug#end()
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ PLUGIN SETTINGS
"===============================================================

"===============================================================
"{{{ POLYGLOT
"===============================================================
let g:tex_flavor='latex'
let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'

augroup MarkdownTexConceal
	" this one is which you're most likely to use?
	autocmd!
	autocmd Filetype markdown let g:tex_conceal=''
	autocmd Filetype markdown setlocal conceallevel=1
augroup end

let g:polyglot_disabled = ['latex', 'markdown']
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ NERD-COMMENTER
"===============================================================
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ VIM-SLIME
"===============================================================
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.2"}

nmap <leader>s V<C-c><C-c>
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ NEOFORMAT
"===============================================================
augroup fmt
	autocmd!
	autocmd BufWritePre !*.md undojoin | Neoformat
augroup END
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ COC.NVIM
"===============================================================
set hidden
set shortmess+=c

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

nnoremap <silent> <leader>cK :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>cd <Plug>(coc-definition)
nnoremap <silent> <leader>ct <Plug>(coc-type-definition)
nnoremap <silent> <leader>ci <Plug>(coc-implementation)
nnoremap <silent> <leader>cr <Plug>(coc-references)
nnoremap <silent> <leader>crn <Plug>(coc-rename)
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ VIM-DOGE
"===============================================================
let g:doge_mapping = '<leader><S-d>'
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ GITGUTTER
"===============================================================
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
omap ic <Plug>(GitGutterTextObjectInnerPending)
omap ac <Plug>(GitGutterTextObjectOuterPending)
xmap ic <Plug>(GitGutterTextObjectInnerVisual)
xmap ac <Plug>(GitGutterTextObjectOuterVisual)
nnoremap <silent> <leader>hh :GitGutterLineHighlightsToggle<CR>
nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>

set updatetime=500
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ INDENT LINE
"===============================================================
let g:indentLine_defaultGroup = 'Whitespace'
let g:indentLine_char ='|' 
let g:indentLine_fileTypeExclude = ['fzf']
let g:indentLine_enabled = 0
let g:indentLine_setColors = 0

nnoremap <silent> <leader>i :IndentLinesToggle<CR>
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ SANDWICH
"===============================================================
let g:sandwich#recipes = g:sandwich#default_recipes
let g:sandwich#recipes += [
			\ {'buns': ["( ", " )"], 'nesting': 1, 'match_syntax': 1, 'input': ['('] },
			\ {'buns': ["[ ", " ]"], 'nesting': 1, 'match_syntax': 1, 'input': ['['] },
			\ {'buns': ["{ ", " }"], 'nesting': 1, 'match_syntax': 1, 'input': ['{'] },
			\ ]
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ AIRLINE
"===============================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ ULTISNIPS
"===============================================================
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

let g:UltiSnipsSnippetDirectories = [$HOME.'/dotfiles/snippets', 'Ultisnips']
let g:UltiSnipsEditSplit="vertical"
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ VIM-MARKDOWN
"===============================================================
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim',
			\'bash=sh', 'ini=dosini', 'r=r']
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ SILICON
"===============================================================
let g:silicon = {
			\ 'theme':     'Monokai Extended',
			\ 'font':           'Victor Mono',
			\ 'background':         '#252525',
			\ 'shadow-color':       '#000000',
			\ 'line-pad':                   2,
			\ 'pad-horiz':                 80,
			\ 'pad-vert':                 100,
			\ 'shadow-blur-radius':         5,
			\ 'shadow-offset-x':            0,
			\ 'shadow-offset-y':            0,
			\ 'line-number':           v:true,
			\ 'round-corner':          v:true,
			\ 'window-controls':       v:true,
			\ 'default-file-pattern':      '',
			\ }
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ FZF
"===============================================================
autocmd! FileType fzf
autocmd FileType fzf setlocal nonumber norelativenumber

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(),
			\   <bang>0)

if has('nvim')
	hi NormalFloat guibg=None
	if exists('g:fzf_colors.bg')
		call remove(g:fzf_colors, 'bg')
	endif

	if stridx($FZF_DEFAULT_OPTS, '--border') == -1
		let $FZF_DEFAULT_OPTS .= ' --border'
	endif

	function! FloatingFZF()
		let width = float2nr(&columns * 0.9)
		let height = float2nr(&lines * 0.7)
		let opts = { 'relative': 'editor',
					\ 'row': (&lines - height) / 2,
					\ 'col': (&columns - width) / 2,
					\ 'width': width,
					\ 'height': height }

		call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
	endfunction

	let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif

command! -bang -nargs=* GGrep
			\ call fzf#vim#grep(
			\   'git grep --line-number '.shellescape(<q-args>), 0,
			\   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir HFiles
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'fd --type file --hidden --no-ignore --exclude ".git/*"'}), <bang>0)

autocmd Filetype fzf tmap <silent> <C-g> <Esc>;q<CR>
autocmd Filetype fzf tmap <silent> <C-d> <Esc>;q<CR>
autocmd Filetype fzf tmap <silent> <C-c> <Esc>;q<CR>

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fho :Files ~/<CR>
nnoremap <silent> <leader>fhi :HFiles<CR>
nnoremap <silent> <leader>fhh :HFiles ~/<CR>
nnoremap <silent> <leader>gg :GGrep<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>rg :Rg<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fal :Lines<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>fhe :Helptags<CR>
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ MUNDO
"===============================================================
nnoremap <silent> <leader>u :MundoToggle<CR>
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ TAGBAR
"===============================================================
nnoremap <silent> <leader>t :TagbarToggle<CR>
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ FUGITIVE
"===============================================================
cnoreabbrev gp Gpush
cnoreabbrev gl Gpull
"===============================================================
"}}}
"===============================================================

"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ THEMING
"===============================================================
colorscheme wpgtkAlt
let g:airline_theme = 'wpgtk'
"===============================================================
"}}}
"===============================================================
