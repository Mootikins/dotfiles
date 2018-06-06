# vi mode agnoster Plugin
# A Powerline-inspired plugin for Agnoster theme
#
# # README
#
# In order for this extension to work properly, you will need a
# [Agnoster-theme](https://gist.github.com/agnoster/3712874).
#
# # Goals
#
# Using Vi mode in Zsh this plugin shows a right prompt segment
# with the current mode.

# Updates editor information when the keymap changes.
# https://gist.github.com/steakknife/2051560
zle-keymap-select() {
  zle reset-prompt
  zle -R
}

zle -N zle-keymap-select

bindkey -v

# Segment drawing
# https://gist.github.com/agnoster/3712874
CURRENT_BG='NONE'
PRIMARY_FG=black

# Characters
RSEGMENT_SEPARATOR="\ue0b2"

# Vi mode
VICMD_INDICATOR="NORMAL"
VIINS_INDICATOR="INSERT"

# Begin an RPROMPT segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
# https://gist.github.com/rjorgenson/83094662ace4d3b82b95
rprompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n "%{%K{$CURRENT_BG}%F{$1}%}$RSEGMENT_SEPARATOR%{$bg%}%{$fg%}"
  else
    echo -n "%F{$1}%{%K{default}%}$RSEGMENT_SEPARATOR%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  # [[ -n $3 ]] && echo -n $3
  [[ -n $3 ]] && echo -n "%{$fg_bold[$2]%} $3 %{$reset_color%}"
}

# Vi mode
prompt_vi_mode() {
  local color mode
  is_normal() {
    test -n "${${KEYMAP/vicmd/$VICMD_INDICATOR}/(main|viins)/}"  # param expans
  }
  if is_normal; then
    color=green
    mode="$VICMD_INDICATOR"
  else
    color=blue
    mode="$VIINS_INDICATOR"
  fi
  rprompt_segment $color white $mode
}

# Timestamp
prompt_timestamp() {
  if [[ $ZSH_TIME = "24" ]]; then
    local time_string="%H:%M:%S"
  else
    local time_string="%L:%M:%S %p"
  fi
  rprompt_segment cyan $PRIMARY_FG "%D{$time_string}"
}

# Right prompt
rprompt_agnoster_vi() {
  prompt_vi_mode
  # prompt_timestamp
  echo -n " "  # rprompt looks awful without a space at the end
}

if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPROMPT='%{%f%b%k%}$(rprompt_agnoster_vi)'
fi
