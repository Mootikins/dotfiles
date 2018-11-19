"
"           __________  ____  ______
"          / ____/ __ \/ __ \/ ____/
"         / /   / / / / /_/ / __/
"        / /___/ /_/ / _, _/ /___
"        \____/\____/_/ |_/_____/
"
"
"{{{BASIC VARIABLE SETTINGS
set number relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2 shiftround noexpandtab
set showcmd mouse=a
set ignorecase smartcase incsearch showmatch hlsearch
set autoread virtualedit+=block lazyredraw
set showmatch
filetype plugin indent on
"Turn On OmniComplete
set omnifunc=syntaxcomplete#Complete
"}}}

"{{{ FORMATTING
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

"Filetype fix for TS
augroup FiletypeGroup
	autocmd!
	" .ts is a Typescript file
	au BufNewFile,BufRead *.ts set filetype=typescript
augroup END

nnoremap g= :call Format()<CR>

autocmd BufWrite *.cpp :call RemoveTrailingSpaces()
autocmd BufWrite *.h :call RemoveTrailingSpaces()
autocmd BufWrite *.py :call RemoveTrailingSpaces()
autocmd BufWrite *.sql :call RemoveTrailingSpaces()
"}}}

" {{{FOLD SETTINGS
set foldmethod=syntax
nnoremap za zA
nnoremap zA za
"}}}

" {{{FILETYPE SPECIFIC SETTINGS
autocmd Filetype asm setlocal shiftwidth=8 softtabstop=8
autocmd Filetype vim setlocal foldmethod=marker
"}}}

"{{{GENERAL REMAPS
let mapleader = " "

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap <CR> :noh<CR>

inoremap kj <Esc>
"}}}

"{{{SPLITS
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <leader>H <C-w>H
nnoremap <leader>J <C-w>J
nnoremap <leader>K <C-w>K
nnoremap <leader>L <C-w>L

nnoremap <leader><C-h> :vertical resize +5<CR>
nnoremap <leader><C-j> :resize +5<CR>
nnoremap <leader><C-k> :resize -5<CR>
nnoremap <leader><C-l> :vertical resize -5<CR>

nnoremap <leader>\ :vnew<CR>
nnoremap <leader>- :new<CR>
"
nnoremap <C-w>\ :vnew<CR>
nnoremap <C-w>- :new<CR>

nnoremap <C-w><C-h> :vertical resize +5<CR>
nnoremap <C-w><C-j> :resize +5<CR>
nnoremap <C-w><C-k> :resize -5<CR>
nnoremap <C-w><C-l> :vertical resize -5<CR>

if has('nvim')
	set inccommand=split
	tnoremap <Esc> <C-\><C-n>
endif
"}}}

"{{{BUFFERS
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :close<CR>

set splitright
set splitbelow
"}}}
