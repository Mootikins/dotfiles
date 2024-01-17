export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/dotfiles/scripts"
export PATH="${PATH}:${HOME}/.cargo/bin/"
export PATH="${PATH}:${HOME}/Raven/bitbake-docker"
export PATH="${PATH}:${HOME}/.screenlayout"

export FZF_COMPLETION_TRIGGER=',,'

if type rg >/dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files --no-hidden --follow --glob "!.git/*"'
fi
export FZF_DEFAULT_OPTS="-m --height 50% --layout=reverse --color fg:7,hl:4,fg+:7,bg+:8,hl+:12 --color info:9,prompt:12,spinner:12,pointer:12,marker:10 --bind alt-k:preview-half-page-up,alt-j:preview-half-page-down"

if type bat &>/dev/null; then
	export FZF_COMPLETION_OPTS="--preview 'bat --decorations=never --color=always --style=grid {}'"

	export FZF_CTRL_T_OPTS="--preview 'bat --decorations=never --color=always --style=grid {}' --preview-window right:50% --bind '?:toggle-preview'"
else
	export FZF_COMPLETION_OPTS="--preview 'bat --decorations=never --color=always --style=grid {}'"

	export FZF_CTRL_T_OPTS="--preview 'head -50 {}' --preview-window right:50% --bind '?:toggle-preview'"
fi
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

export HISTORY_IGNORE="(PRIVATE)"

if type eza &>/dev/null; then
	alias ls=eza
	alias la="eza -a"
	alias ll="eza -l"
fi

# Use fd to generate the list for directory completion
if type fd &>/dev/null; then
	# Use fd (https://github.com/sharkdp/fd) instead of the default find
	# command for listing path candidates.
	# - The first argument to the function ($1) is the base path to start traversal
	# - See the source code (completion.{bash,zsh}) for the details.
	_fzf_compgen_path() {
		fd --follow --exclude ".git" --exclude "Music" . "$1"
	}

	# Use fd to generate the list for directory completion
	_fzf_compgen_dir() {
		fd --type d --follow --exclude ".git" --exclude "Music" . "$1"
	}
	export FZF_DEFAULT_COMMAND='fd --exclude "Music" --exclude "Deezloader Music" .'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export KEYTIMEOUT=15
if type go &>/dev/null; then
	export GOPATH=$(go env GOPATH)
fi

if type nvim &>/dev/null; then
	export VISUAL=nvim
	alias vimdiff="nvim -d"
	alias fug='nvim +G "+wincmd k" +bd'
else
	export VISUAL=vim
fi

if type hub &>/dev/null; then
	eval "$(hub alias -s)"
fi

is_in_git_repo() {
	git rev-parse HEAD >/dev/null 2>&1
}

if type fzf &>/dev/null; then
	gcobf-list() {
		is_in_git_repo || return
		git branch -a --color=always | grep -v '/HEAD\s' | sort |
			fzf --ansi --multi --tac --preview-window right:70% \
				--preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
			sed 's/^..//' | cut -d' ' -f1 |
			sed 's#^remotes/##'
	}

	gcohf-list() {
		is_in_git_repo || return
		git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --color=always |
			fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
				--header 'Press CTRL-S to toggle sort' \
				--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
			grep -o "[a-f0-9]\{7,\}"
		if [ $? -eq 130 ]; then
			true
		fi
	}

	alias gcobf='git checkout `gcobf-list`'
	alias gcohf='git checkout `gcohf-list`'

	glf() {
		git log \
			--graph \
			--exclude='save/*' \
			--exclude='trash/*' \
			--color=always \
			--format="%C(auto)%h%d %s %C(4)%C(bold)%an, %cr" "$@" |
			fzf \
				--ansi \
				--no-sort \
				--reverse \
				--preview "echo {} | \
    grep -o '[a-f0-9]\{7\}' | \
    head -1 | \
    xargs -I % sh -c 'git show --color=always %'" \
				--bind "enter:execute:( \
    grep -o '[a-f0-9]\{7\}' \
    | head -1 \
    | xargs -I % sh -c 'git show --color=always % \
    | less -R' \
    ) << 'FZF-EOF' {} FZF-EOF"
		# Do not register a user exit of fzf as an error.
		if [ $? -eq 130 ]; then
			true
		fi
	}
fi

__delta_side_by_side_width() {
	local columns=$(tput cols)
	# Enough room for two side-by-side 80-char diffs with some room for line numbers to spare
	if [ $columns -ge 170 ]; then
		export DELTA_FEATURES="+side-by-side"
	else
		export DELTA_FEATURES=""
	fi
}

precmd() {
	__delta_side_by_side_width
}

export EDITOR=$VISUAL
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias glotags="git log --graph --oneline --date=short \$(git describe --tags --candidates=1 | cut -d'-' -f1)..HEAD"
alias nv=$EDITOR
alias bbd=bitbake-docker

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
