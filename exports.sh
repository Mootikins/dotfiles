export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS="-m --height 25% --layout=reverse --color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255 --color info:7,prompt:2,spinner:1,pointer:232,marker:1"
if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files --no-ignore --no-hidden --follow --glob "!.git/*"'
fi

if type bat &> /dev/null; then
	export FZF_COMPLETION_OPTS="--preview 'bat --decorations=always --color=always --style=header,grid --line-range :50 {}'"
fi

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

export KEYTIMEOUT=15

if type nvim &> /dev/null; then
	export VISUAL=nvim
	alias magit="nvim -c 'MagitOnly'"
else
	export VISUAL=vim
	alias magit="vim -c 'MagitOnly'"
fi

eval "$(hub alias -s)"

export EDITOR="$VISUAL"
alias tma="tmux attach"
alias tmat="tmux attach -t "
alias tmks="tmux kill-server"
alias tmk="tmux kill-session -t "
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.local/share/nvim/plugged/vim-live-latex-preview/bin/"
export PATH="${PATH}:${HOME}/.gem/ruby/2.5.0/bin/:/usr/lib/ruby/gems/2.5.0/b"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/dotfiles/scripts"
