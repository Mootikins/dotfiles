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

Plug 'junegunn/vim-plug'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

Plug 'vimwiki/vimwiki'

Plug 'simnalamburt/vim-mundo'
Plug 'majutsushi/tagbar'

Plug 'mattn/emmet-vim'

Plug 'sheerun/vim-polyglot'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

Plug 'wellle/targets.vim'
Plug 'machakann/vim-sandwich'

Plug 'vim-scripts/nextval'

Plug 'tmux-plugins/vim-tmux'
Plug 'wincent/terminus'
Plug 'christoomey/vim-tmux-navigator'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'
Plug 'ying17zi/vim-live-latex-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'airblade/vim-gitgutter'
Plug 'RRethy/vim-hexokinase'

Plug 'dylanaraps/wal.vim'
Plug 'deviantfero/wpgtk.vim'
Plug 'patstockwell/vim-monokai-tasty'

Plug 'omnisharp/omnisharp-vim'
Plug 'valloric/youcompleteme'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

Plug 'romainl/vim-devdocs'

if has('nvim')
	Plug 'w0rp/ale'
else
	Plug 'vim-syntastic/syntastic'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ PLUGIN SETTINGS
"===============================================================

"===============================================================
"{{{ HEXOKINASE
"===============================================================
let g:Hexokinase_highlighters = ['virtual']
let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'colour_names']
let g:Hexokinase_ftAutoload = ['css', 'xml', 'html', 'php']
let g:Hexokinase_refreshEvents = ['TextChanged', 'TextChangedI']
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ VIM-DEVDOCS
"===============================================================
set keywordprg=:DD
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ ALE/SYNTASTIC CONFIG
"===============================================================

"===============================================================
"{{{ ALE
"===============================================================
if has('nvim')
	" ALE changes
	let g:ale_linters = {
				\'cpp': ['gcc'],
				\'typescript': ['tsserver'],
				\'rust': ['rls'],
				\'php': ['phpcs'],
				\'cs': ['OmniSharp']
				\}
"				\'sql': ['sqlint'],

	let g:ale_fixers = {
				\'javascript': 'prettier',
				\'typescript': 'prettier',
				\'rust': 'rustfmt'
				\}

	let g:ale_fix_on_save = 1
	let g:ale_rust_rustfmt_options = '--force'
	let g:ale_rust_rls_toolchain = 'nightly'

	let g:ale_c_parse_makefile = 1
	"===============================================================
	"}}}
	"===============================================================

	"===============================================================
	"{{{ SYNTASTIC
	"===============================================================
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
"===============================================================
"}}}
"===============================================================

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
"{{{ POLYGLOT
"===============================================================
let g:tex_flavor='latex'
let g:vimtex_view_method='mupdf'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:polyglot_disabled = ['latex']
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ AIRLINE
"===============================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
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
"{{{ YOUCOMPLETEME
"===============================================================
" turn on completion in comments
let g:ycm_complete_in_comments=1
" load ycm conf by default
let g:ycm_confirm_extra_conf=0
" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1
" start completion from the first character
let g:ycm_min_num_of_chars_for_completion=1
" close preview window after completion
let g:ycm_autoclose_preview_window_after_completion=1
" Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.local/share/nvim/plugged/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ VIMWIKI
"===============================================================
let g:vimwiki_folding='expr'
let g:vimwiki_list = [{ 'path': '~/Diary/', 'syntax': 'markdown', 'ext': '.md' },
                     \{ 'path': '~/SDSMT/', 'syntax': 'markdown', 'ext': '.md' },
                     \{ 'path': '~/databaseP1/', 'syntax': 'markdown', 'ext': '.md' }]
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ DOXYGEN TOOLKIT
"===============================================================
let g:DoxygenToolkit_authorName="Matthew Krohn"
"===============================================================
"}}}
"===============================================================

"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ PLUGIN BINDINGS
"===============================================================
autocmd! FileType fzf
autocmd FileType fzf setlocal nonumber norelativenumber
autocmd FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

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

autocmd Filetype fzf tmap <silent> <C-g> <Esc>;q<CR>
autocmd Filetype fzf tmap <silent> <C-d> <Esc>;q<CR>
autocmd Filetype fzf tmap <silent> <C-c> <Esc>;q<CR>

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

nnoremap <silent> <leader>u :MundoToggle<CR>

nnoremap <silent> <leader>t :TagbarToggle<CR>

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

nnoremap <silent> <leader>] :YcmCompleter GoTo<CR>

cnoreabbrev gp Gpush
cnoreabbrev gl Gpull
"===============================================================
"}}}
"===============================================================

"===============================================================
"{{{ COLORSCHEME AND GENERAL THEMES
"===============================================================
colorscheme wpgtkAlt
let g:airline_theme = 'wpgtk'
let g:airline#extensions#ale#enabled = 1
"===============================================================
"}}}
"===============================================================
