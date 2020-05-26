"
"           __________  ____  ______
"          / ____/ __ \/ __ \/ ____/
"         / /   / / / / /_/ / __/
"        / /___/ /_/ / _, _/ /___
"        \____/\____/_/ |_/_____/
"
"
"====================================================
"{{{ BASIC VARIABLE SETTINGS
"====================================================
set number relativenumber
set tabstop=3 softtabstop=3 shiftwidth=3 shiftround noexpandtab
set showcmd mouse=a
set ignorecase smartcase incsearch showmatch hlsearch
set autoread virtualedit+=block
set showmatch noshowmode lazyredraw
set wildmenu wildmode=full
set undofile
set undodir=$HOME/.vim/undo
set spelllang=en_us
set nowrap

if has('nvim')
	set signcolumn=yes:2
else
	set signcolumn=yes
endif
set splitright splitbelow
set exrc

filetype plugin indent on
set smartindent
syntax on

" Turn On OmniComplete
set omnifunc=syntaxcomplete#Complete
set showbreak=->\ 

if &diff
	set diffopt=algorithm:patience
endif
"====================================================
"}}}
"====================================================

"====================================================
"{{{ FOLD SETTINGS
"====================================================
set foldmethod=syntax
" Gets toggled with zi
set nofoldenable

nnoremap za zA
nnoremap zA za

nnoremap <silent> zl zo
nnoremap <silent> zh zc
nnoremap <silent> zL zO
nnoremap <silent> zH zC
"====================================================
"}}}
"====================================================

"====================================================
"{{{ FILETYPE SPECIFIC SETTINGS
"====================================================
function OpenInZathura()
	let b:pdf_filename = split(@%, '\.')[0].'.pdf'
	execute "silent !zathura ".b:pdf_filename
endfunction

augroup FiletypeGroup
	autocmd!
	" .ts is a Typescript file
	autocmd BufNewFile,BufRead *.rasi set filetype=css

	autocmd Filetype asm setlocal shiftwidth=8 softtabstop=8
	autocmd Filetype vim setlocal foldmethod=marker foldenable
	autocmd Filetype vim let b:autoformat_remove_trailing_spaces=0
	autocmd Filetype tmux setlocal foldmethod=marker foldenable
	autocmd Filetype xdefaults setlocal foldmethod=marker
	autocmd Filetype python setlocal shiftwidth=4 softtabstop expandtab
	autocmd Filetype markdown setlocal expandtab tabstop=2 softtabstop=2 textwidth=100 formatoptions+=t
	autocmd Filetype help execute "wincmd L | vertical resize 85"
	autocmd Filetype html nnoremap <buffer> <silent> <C-o> :silent !xdg-open %<CR>
	autocmd Filetype pandoc setlocal expandtab textwidth=80 formatoptions+=t spell
	autocmd Filetype pandoc nnoremap <buffer> <silent> <C-o> :call OpenInZathura()<CR>
	autocmd Filetype rust setlocal tabstop=3 softtabstop=3 shiftwidth=3
	autocmd Filetype vimwiki setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab filetype=pandoc.vimwiki
augroup END
"====================================================
"}}}
"====================================================

"====================================================
"{{{ GENERAL RE-MAPS
"====================================================
let mapleader = " "
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
xnoremap ; :
xnoremap : ;

noremap <silent> H ^
noremap <silent> L g_

nnoremap <silent> gT :tabnew<CR>

nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>

nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>

nnoremap <silent> g<CR> :noh<CR>

inoremap <silent> kj <Esc>

" move visual selection up/down line at a time
xnoremap <silent> K <Esc>'<kdd'>pgv
xnoremap <silent> J <Esc>'>jdd'<Pgv

inoremap <silent> <C-f> <C-g>u<Esc>[s1z=`]a<c-g>u

" Show highlight group of character/word under cursor
function! SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <silent> <F10> :call SynStack()<CR>

nnoremap Q @@
"====================================================
"}}}
"====================================================

"====================================================
"{{{ SPLITS
"====================================================
nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>j <C-w>j
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>l <C-w>l

nnoremap <silent> <leader>H <C-w>H
nnoremap <silent> <leader>J <C-w>J
nnoremap <silent> <leader>K <C-w>K
nnoremap <silent> <leader>L <C-w>L

nnoremap <silent> <leader><C-h> :vertical resize +5<CR>
nnoremap <silent> <leader><C-j> :resize +5<CR>
nnoremap <silent> <leader><C-k> :resize -5<CR>
nnoremap <silent> <leader><C-l> :vertical resize -5<CR>

nnoremap <silent> <leader>\ :vnew<CR>
nnoremap <silent> <leader>- :new<CR>

nnoremap <silent> <C-w><C-h> :vertical resize -5<CR>
nnoremap <silent> <C-w><C-j> :resize -5<CR>
nnoremap <silent> <C-w><C-k> :resize +5<CR>
nnoremap <silent> <C-w><C-l> :vertical resize +5<CR>

if has('nvim')
	set inccommand=split

	augroup CleanTerm
		autocmd!
		autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
	augroup END

	tnoremap <silent> <Esc> <C-\><C-n>
else
	colorscheme darkblue
	set background=dark
	highlight SignColumn ctermbg=0
	highlight Folded ctermbg=0
endif

function! WinBufSwap()
	let thiswin = winnr()
	let thisbuf = bufnr("%")
	let lastwin = winnr("#")
	let lastbuf = winbufnr(lastwin)

	exec  lastwin . " wincmd w" ."|".
				\ "buffer ". thisbuf ."|".
				\ thiswin ." wincmd w" ."|".
				\ "buffer ". lastbuf
endfunction

nnoremap <C-w><C-r> :call WinBufSwap()<CR>

function! DeleteEmptyBuffers()
	let [i, n; empty] = [1, bufnr('$')]
	while i <= n
		if bufexists(i) && bufname(i) == ''
			call add(empty, i)
		endif
		let i += 1
	endwhile
	if len(empty) > 0
		exe 'bdelete' join(empty)
	endif
endfunction

command! DeleteEmpty call DeleteEmptyBuffers()
"====================================================
"}}}
"====================================================
