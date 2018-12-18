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
set tabstop=2 softtabstop=2 shiftwidth=2 shiftround noexpandtab
set showcmd mouse=a
set ignorecase smartcase incsearch showmatch hlsearch
set autoread virtualedit+=block lazyredraw
set showmatch noshowmode
set wildmenu wildmode=full
set undofile
set undodir=$HOME/.vim/undo
filetype plugin indent on
syntax on
" Turn On OmniComplete
set omnifunc=syntaxcomplete#Complete
let &showbreak='-> '

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"====================================================
"}}}
"====================================================

"====================================================
"{{{ FORMATTING
"====================================================
function! RemoveTrailingSpaces()
	silent! execute '%s/\s\+$//ge'
	silent! execute 'g/\v^$\n*%$/norm! dd'
endfunction

function! Format()
	silent! execute 'norm! mz'

	if &ft ==? 'c' || &ft ==? 'cpp' || &ft ==? 'php'
		set formatprg=astyle\ --mode=c
		silent! execute 'norm! gggqG'
	elseif &ft ==? 'java'
		set formatprg=astyle\ --mode=java
		silent! execute 'norm! gggqG'
	endif

	silent! call RemoveTrailingSpaces()
	silent! execute 'retab'
	silent! execute 'gg=G'
	silent! execute 'norm! `z'
	set formatprg=
endfunction

" Filetype fix for TS
augroup FiletypeGroup
	autocmd!
	" .ts is a Typescript file
	au BufNewFile,BufRead *.ts set filetype=typescript
augroup END

nnoremap <silent> g= :call Format()<CR>

autocmd BufWrite *.cpp :call RemoveTrailingSpaces()
autocmd BufWrite *.h :call RemoveTrailingSpaces()
autocmd BufWrite *.py :call RemoveTrailingSpaces()
autocmd BufWrite *.sql :call RemoveTrailingSpaces()
autocmd BufWrite *.txt :call RemoveTrailingSpaces()
"====================================================
"}}}
"====================================================

"====================================================
"{{{ FOLD SETTINGS
"====================================================
set foldmethod=syntax
nnoremap za zA
nnoremap zA za
"====================================================
"}}}
"====================================================

"====================================================
"{{{ FILETYPE SPECIFIC SETTINGS
"====================================================
autocmd Filetype asm setlocal shiftwidth=8 softtabstop=8
autocmd Filetype vim setlocal foldmethod=marker
autocmd Filetype tmux setlocal foldmethod=marker
autocmd Filetype xdefaults setlocal foldmethod=marker
"====================================================
"}}}
"====================================================

"====================================================
"{{{ GENERAL RE-MAPS
"====================================================
let mapleader = " "

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap <silent> H ^
nnoremap <silent> L g_
xnoremap <silent> H ^
xnoremap <silent> L g_

" move visual selection up/down line at a time
xnoremap <silent> K <Esc>'<kdd'>pgv
xnoremap <silent> J <Esc>'>jdd'<Pgv

" Show highlight group of character/word under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

nnoremap <silent> <CR> :noh<CR>

inoremap <silent> kj <Esc>
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
"
nnoremap <silent> <C-w>\ :vnew<CR>
nnoremap <silent> <C-w>- :new<CR>

nnoremap <silent> <C-w><C-h> :vertical resize +5<CR>
nnoremap <silent> <C-w><C-j> :resize +5<CR>
nnoremap <silent> <C-w><C-k> :resize -5<CR>
nnoremap <silent> <C-w><C-l> :vertical resize -5<CR>

if has('nvim')
	set inccommand=split
	tnoremap <silent> <Esc> <C-\><C-n>
endif
"====================================================
"}}}
"====================================================

"====================================================
"{{{ BUFFERS
"====================================================
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>x :close<CR>

set splitright
set splitbelow
"====================================================
"}}}
"====================================================

"====================================================
"{{{ VIM SPECIFIC
"====================================================
if has('vim')
	set background=dark
	colorscheme darkblue
endif
"====================================================
"}}}
"====================================================
