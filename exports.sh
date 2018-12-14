export FZF_COMPLETION_TRIGGER='...'
export FZF_DEFAULT_OPTS="-m --height 40% --layout=reverse"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --no-hidden --follow --glob "!.git/*"'
export FZF_COMPLETION_OPTS="--preview 'bat --decorations=always --color=always --style=header,grid --line-range :50 {}'"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git" . "$1"
}

export NPM_PACKAGES="/home/moot/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

export KEYTIMEOUT=15

if [ type nvim &> /dev/null ]; then
	export VISUAL=nvim
else
	export VISUAL=vim
fi

eval "$(hub alias -s)"

export EDITOR="$VISUAL"
alias tma="tmux attach"
alias tmat="tmux attach -t "
alias tmks="tmux kill-server"
alias tmk="tmux kill-session -t "
alias magit="vim -c 'MagitOnly'"
alias magit="nvim -c 'MagitOnly'"
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.local/share/nvim/plugged/vim-live-latex-preview/bin/"
export PATH="${PATH}:${HOME}/.gem/ruby/2.5.0/bin/:/usr/lib/ruby/gems/2.5.0/b"
export PATH="${PATH}:${HOME}/go/bin"
