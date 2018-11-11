"           __________  ____  ______
"          / ____/ __ \/ __ \/ ____/
"         / /   / / / / /_/ / __/   
"        / /___/ /_/ / _, _/ /___   
"        \____/\____/_/ |_/_____/   
"                           
"
"
set number relativenumber 
set tabstop=2 softtabstop=2 shiftwidth=2 shiftround noexpandtab
set showcmd mouse=a
set ignorecase smartcase incsearch showmatch hlsearch
set autoread virtualedit+=block lazyredraw
set scrolloff=10 icm=split
filetype plugin indent on

"Set fill characters for tabs and other highlights
set fillchars+=vert:\ 

"Highlight columns 81 and 101 on lines with that many characters
call matchadd('ColorColumn', '\%81v', 100)
call matchadd('ColorColumn', '\%101v', 100)

"Shows pairs of braces, parens etc
set showmatch

" Assembly local whitespace settings
autocmd Filetype asm setlocal shiftwidth=8 softtabstop=8

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

nnoremap g= :call Format()<CR>

autocmd BufWrite *.cpp :call RemoveTrailingSpaces()
autocmd BufWrite *.h :call RemoveTrailingSpaces()
autocmd BufWrite *.py :call RemoveTrailingSpaces()
autocmd BufWrite *.sql :call RemoveTrailingSpaces()

"Fold Settings
set foldmethod=syntax nofoldenable
nnoremap za zA
nnoremap zA za

" No more annoying files
set nobackup
set noswapfile
set noundofile
set nowritebackup

" Change asm comment char
autocmd Filetype asm setlocal commentstring=@%s shiftwidth=8 softtabstop=8

"Turn On OmniComplete
set omnifunc=syntaxcomplete#Complete

"GENERAL REMAPS
let mapleader = " "

"Splits
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

nnoremap <leader>wq :wq<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

"Leave Insert Mode
inoremap kj <Esc>

"Open Splits to Right and Bottom
set splitright
set splitbelow

"Alternate Split Creation
nnoremap <C-w>\ :vnew<CR>
nnoremap <C-w>- :new<CR>

"Split Resizing
nnoremap <C-w><C-h> :vertical resize +5<CR>
nnoremap <C-w><C-j> :resize +5<CR>
nnoremap <C-w><C-k> :resize -5<CR>
nnoremap <C-w><C-l> :vertical resize -5<CR>

nnoremap <CR> :noh<CR>

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
