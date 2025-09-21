# Plugin configurations
# Which plugins would you like to load?
plugins=(
  z
  git
  docker
  vi-mode
  zsh-autosuggestions
  zsh-completions
  zsh-interactive-cd
)

# Set completion paths
fpath+=~/.zfunc
fpath+=~/.local/share/zsh/site-functions/
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Completion settings
zstyle ':completion:*' completer _expand _complete _ignored _match _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '~/.zshrc'