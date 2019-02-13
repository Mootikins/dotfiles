"
"            __    __) _____ __     __) 
"           (, )  /   (, /  (, /|  /|   
"              | /      /     / | / |   
"              |/   ___/__ ) /  |/  |_  
"              |  (__ /   (_/   '       
"                            
"
if exists("g:gui_oni")
	source ~/dotfiles/vim/core.vim
	source ~/dotfiles/vim/highlights.vim
elseif has('nvim')
	source ~/dotfiles/vim/core.vim
	source ~/dotfiles/vim/fullPlug.vim
	source ~/dotfiles/vim/highlights.vim
else
	source ~/dotfiles/vim/core.vim
	source ~/dotfiles/vim/highlights.vim
endif
