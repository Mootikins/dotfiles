# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Zsh settings
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Powerlevel9k settings (legacy support)
typeset POWERLEVEL9K_VI_INSERT_MODE_STRING="%BINSERT"
typeset POWERLEVEL9K_VI_COMMAND_MODE_STRING="%BNORMAL"
typeset POWERLEVEL9K_STATUS_OK_BACKGROUND='008'
typeset POWERLEVEL9K_STATUS_OK_FOREGROUND='040'
typeset POWERLEVEL9K_STATUS_ERROR_FOREGROUND='196'
typeset POWERLEVEL9K_STATUS_ERROR_BACKGROUND='008'
typeset POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs virtualenv)
typeset POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode)
typeset POWERLEVEL9K_DIR_HOME_BACKGROUND='012'
typeset POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='012'
typeset POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='012'
typeset POWERLEVEL10K_DIR_ETC_BACKGROUND='012'
typeset POWERLEVEL9K_VCS_CLEAN_BACKGROUND='010'
typeset POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='010'
typeset POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='010'
typeset POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='010'
typeset POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='012'
typeset POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='000'
typeset POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='000'
typeset POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_unique'
typeset POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
typeset POWERLEVEL9K_SHORTEN_DELIMITER=''
typeset ZLE_RPROMPT_INDENT=0
typeset POWERLEVEL9K_VCS_ACTIONFORMAT_FOREGROUND=black

# Source modular configuration files
for file in ~/.zshrc.d/*.sh(N); do
  source "$file"
done

# Initialize completion
autoload -Uz compinit
compinit

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh