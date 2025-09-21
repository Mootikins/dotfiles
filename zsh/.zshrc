# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh-my-zsh settings
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Load oh-my-zsh plugins
plugins=(
  z
  git
  vi-mode
  history-substring-search
)

# Load completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Add custom plugin paths if they exist
[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && \
  plugins+=(zsh-autosuggestions)

[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive-cd" ] && \
  plugins+=(zsh-interactive-cd)

[ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/docker" ] && \
  plugins+=(docker)

# Load modular configurations from zshrc.d
if [ -d ~/.zshrc.d ]; then
  for config in ~/.zshrc.d/*.zsh(N); do
    source $config
  done
fi