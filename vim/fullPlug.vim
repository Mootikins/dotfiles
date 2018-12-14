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
"====================================================
"{{{PLUGINS
"====================================================
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'

Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/nextval'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'

Plug 'jreybert/vimagit'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'ying17zi/vim-live-latex-preview', { 'for': 'tex' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'
Plug 'gko/vim-coloresque'

Plug 'dylanaraps/wal.vim'

Plug 'valloric/youcompleteme'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

if has('nvim')
	Plug 'w0rp/ale'
else
	Plug 'vim-syntastic/syntastic'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()
"====================================================
"}}}
"====================================================

"====================================================
"{{{YOUCOMPLETEME SETTINGS
"====================================================
" turn on completion in comments
let g:ycm_complete_in_comments=1

" load ycm conf by default
let g:ycm_confirm_extra_conf=0

" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1

" start completion from the first character
let g:ycm_min_num_of_chars_for_completion=1

"Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"====================================================
"}}}
"====================================================

"====================================================
"{{{PLUGIN BINDINGS
"====================================================
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=never --smart-case '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(),
			\   <bang>0)

command! -bang -nargs=* GGrep
			\ call fzf#vim#grep(
			\   'git grep --line-number '.shellescape(<q-args>), 0,
			\   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

autocmd Filetype fzf tmap <silent> <C-g> <Esc>:q<CR>

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fh :Files ~/<CR>
nnoremap <silent> <leader>gg :GGrep<CR>
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>rg :Rg<CR>
nnoremap <silent> <leader>fl :BLines<CR>
nnoremap <silent> <leader>fal :Lines<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ft :Tags<CR>
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>fH :Helptags<CR>

nnoremap <leader>mg :Magit<CR>
nnoremap <leader>mo :MagitOnly<CR>
"====================================================
"}}}
"====================================================

"====================================================
"{{{ALE/SYNTASTIC CONFIG
"====================================================

"====================================================
"{{{ALE
"====================================================
if has('nvim')
	" ALE changes
	let g:ale_linters = {
				\'cpp': ['gcc'],
				\'typescript': ['tsserver']
				\}

	let g:ale_fixers = {
				\'javascript': 'prettier',
				\'typescript': 'prettier',
				\}

	let g:ale_completion_enabled = 1
	let g:ale_c_parse_makefile = 1
	"====================================================
	"}}}
	"====================================================

	"====================================================
	"{{{SYNTASTIC
	"====================================================
else
	" Syntastic changes
	let g:syntastic_cpp_checkers = ['gcc']
	let g:syntastic_cpp_compiler = 'gcc'
	let g:syntastic_cpp_compiler_options = ' -std=c++11'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_mode_map = {
				\ "mode": "active",
				\ "passive_filetypes": ["asm"] }

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_open = 1
	let g:syntastic_check_on_wq = 0
endif
"====================================================
"}}}
"====================================================

"====================================================
"}}}
"====================================================

"====================================================
"{{{COLORSCHEME AND GENERAL THEMES
"====================================================
colorscheme wal
let g:airline_theme = 'wal'
let g:airline#extensions#ale#enabled = 1
"====================================================
"}}}
"====================================================

"====================================================
"{{{TMUX CURSOR FIX
"====================================================
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"====================================================
"}}}
"====================================================

"====================================================
"{{{EDIT/SOURCE DOTFILE
"====================================================
nnoremap <silent> <leader>ed :edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>so :source ~/.config/nvim/init.vim<CR>
"====================================================
"}}}
"====================================================
