# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/moot/dotfiles/zsh/zshrc.d/60-completion.zsh'

autoload -Uz compinit
compinit
# End of lines added by compinstall