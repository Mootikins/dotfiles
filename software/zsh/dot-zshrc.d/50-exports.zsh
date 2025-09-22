# Source secrets file if it exists
[[ -f "${HOME}/.secrets" ]] && source "${HOME}/.secrets"

# Path exports
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/dotfiles/scripts"
export PATH="${PATH}:${HOME}/.cargo/bin/"
export PATH="${PATH}:${HOME}/Raven/bitbake-docker"
export PATH="${PATH}:${HOME}/.screenlayout"
export PATH="${PATH}:${HOME}/.bun/bin"


# FZF exports
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

# Use fd for fzf if available
if type fd &>/dev/null; then
	export FZF_DEFAULT_COMMAND='fd --exclude "Music" --exclude "Deezloader Music" .'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Go path
if type go &>/dev/null; then
	export GOPATH=$(go env GOPATH)
fi

# HuggingFace cache
export HF_HOME="${HOME}/models/.hf-cache"

# History settings
export HISTORY_IGNORE="(PRIVATE)"
export KEYTIMEOUT=15

# opencode
export PATH=/home/moot/.opencode/bin:$PATH