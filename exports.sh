export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS="-m --height 25% --layout=reverse --color fg:7,bg:0,hl:4,fg+:7,bg+:8,hl+:12 --color info:9,prompt:12,spinner:12,pointer:12,marker:10"
if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files --no-hidden --follow --glob "!.git/*"'
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
else
	export VISUAL=vim
fi

if type hub &> /dev/null; then
	eval "$(hub alias -s)"
fi

glf() {
    git log --graph --exclude='save/*' --exclude='trash/*' --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%an, %cr" "$@" |
    fzf --ansi --no-sort --reverse --preview  "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always %'" \
        --bind "enter:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
    # Do not register a user exit of fzf as an error.
    if [ $? -eq 130 ]; then
        true
    fi
}

export TERM=xterm-256color
export EDITOR="$VISUAL"
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias glotags="git log --graph --oneline --date=short \$(git describe --tags --candidates=1 | cut -d'-' -f1)..HEAD"
alias nv=$VISUAL
export PATH="${PATH}:${HOME}/.local/bin/"
export PATH="${PATH}:${HOME}/.local/share/nvim/plugged/vim-live-latex-preview/bin/"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/dotfiles/scripts"
export PATH="${PATH}:${HOME}/.cargo/bin/"
