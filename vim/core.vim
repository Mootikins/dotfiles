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
set scrolloff=10

"Set fill characters for tabs and other highlights
set fillchars+=vert:\ 
set list listchars=tab:\|\ 

"Highlight columns 81 and 101 on lines with that many characters
call matchadd('ColorColumn', '\%81v', 100)
call matchadd('ColorColumn', '\%101v', 100)

"Shows pairs of braces, parens etc
set showmatch
set matchpairs+=<:>

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
set foldmethod=syntax foldnestmax=1

" No more annoying files
set nobackup
set noswapfile
set noundofile
set nowritebackup

" Change asm comment char
autocmd Filetype asm setlocal commentstring=@%s shiftwidth=8 softtabstop=8

"Turn On OmniComplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"GENERAL REMAPS
let mapleader = " "

"Leave Insert Mode
inoremap kj <Esc>

"Create Splits
nnoremap <leader>\ :vnew<CR>
nnoremap <leader>- :new<CR>

"Open Splits to Right and Bottom
set splitright
set splitbelow

"Split Selection, Directional
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"Split Movement
nnoremap <leader>H <C-w>H
nnoremap <leader>J <C-w>J
nnoremap <leader>K <C-w>K
nnoremap <leader>L <C-w>L

"Split Resizing
nnoremap <leader><C-h> :vertical resize +10<CR>
nnoremap <leader><C-j> :resize -10<CR>
nnoremap <leader><C-k> :resize +10<CR>
nnoremap <leader><C-l> :vertical resize -10<CR>

"Tabs
nnoremap <leader><C-n> :tabNext<CR>
nnoremap <leader><C-p> :tablast<CR>
nnoremap <leader><C-t> :tabnew<CR>
nnoremap <leader><C-q> :tabclose<CR>
nnoremap <CR> :noh<CR>

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Use C-n and C-p to move buffers
nnoremap <C-n> :bnext<CR>

"Open NerdTree
nnoremap <leader>t :NERDTreeToggle<CR>
