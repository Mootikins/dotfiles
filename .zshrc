if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-moot.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-moot.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# These can be used if using high resolution displays (looks bad with bitmap fonts)
# POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_MODE='awesome-patched'
export POWERLEVEL9K_VCS_ACTIONFORMAT_FOREGROUND=black
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  z
  git
  git-flow
  vi-mode
  history-substring-search
  zsh-autosuggestions
  zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Remove hostname@comp 
# prompt_context() {}

POWERLEVEL9K_VI_INSERT_MODE_STRING="%BINSERT"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="%BNORMAL"

POWERLEVEL9K_STATUS_OK_BACKGROUND='008'
POWERLEVEL9K_STATUS_OK_FOREGROUND='040'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='196'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='008'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vi_mode)

POWERLEVEL9K_DIR_HOME_BACKGROUND='012'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='012'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='012'
POWERLEVEL10K_DIR_ETC_BACKGROUND='012'

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='010'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='010'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='010'

POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='010'
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='012'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='000'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='000'
POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_unique'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=''

bindkey kj vi-cmd-mode
bindkey '^f' forward-word
bindkey '^g' autosuggest-accept
bindkey '^b' backward-delete-word
bindkey '^e' edit-command-line
bindkey -M viins '^p' history-substring-search-up
bindkey -M viins '^n' history-substring-search-down

if [ -d ~/.config/wpg ]; then
  # Import colorscheme from 'wal' asynchronously
  # &   # Run the process in the background.
  # ( ) # Hide shell job control messages.
  (cat ~/.config/wpg/sequences &)

  # To add support for TTYs this line can be optionally added.
  source ~/.cache/wal/colors-tty.sh
fi

source ~/dotfiles/exports.sh

fpath+=~/.zfunc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /home/moot/.config/broot/launcher/bash/br

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
