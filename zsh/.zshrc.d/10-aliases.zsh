# General aliases
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias glotags="git log --graph --oneline --date=short \$(git describe --tags --candidates=1 | cut -d'-' -f1)..HEAD"
alias nv="$EDITOR"
alias bbd=bitbake-docker
setopt transient_rprompt

# Editor aliases
if type nvim &>/dev/null; then
	alias vimdiff="nvim -d"
	alias fug='nvim +G "+wincmd k" +bd'
fi