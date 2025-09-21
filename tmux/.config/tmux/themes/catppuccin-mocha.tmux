#!/usr/bin/env bash
# vim: filetype=tmux:foldmethod=marker

# COLORS =================================================================== {{{
%hidden ROSEWATER="#F5E0DC"
%hidden FLAMINGO="#F2CDCD"
%hidden PINK="#F5C2E7"
%hidden MAUVE="#CBA6F7"
%hidden RED="#F38BA8"
%hidden MAROON="#EBA0AC"
%hidden PEACH="#FAB387"
%hidden YELLOW="#F9E2AF"
%hidden GREEN="#A6E3A1"
%hidden TEAL="#94E2D5"
%hidden SKY="#89DCEB"
%hidden SAPPHIRE="#74C7EC"
%hidden BLUE="#89B4FA"
%hidden LAVENDER="#B4BEFE"

%hidden SUBTEXT1="#BAC2DE"
%hidden SUBTEXT0="#A6ADC8"
%hidden OVERLAY2="#9399B2"
%hidden OVERLAY1="#7F849C"
%hidden OVERLAY0="#6C7086"
%hidden SURFACE2="#585B70"
%hidden SURFACE1="#45475A"
%hidden SURFACE0="#313244"

%hidden BASE="#1E1E2E"
%hidden MANTLE="#181825"
%hidden CRUST="#11111B"
# ========================================================================== }}}

# POWERLINE TMUX THEME ===================================================== {{{
# 
# 

# status
set -g status-position bottom
set -g status "on"
set -g status-justify "left"
set -g status-interval 15
set -g status-style "fg=$BLUE,bg=$MANTLE"

#Left side of status bar
set -g status-left-length "100"
set -g status-left-style "bg=$MANTLE,fg=$MANTLE"
set -g status-left "#[fg=$BLUE,bg=$MANTLE]#[fg=$MANTLE,bg=$BLUE,bold] #S #[fg=$BLUE,bg=$MANTLE,nobold]"

#12 hour time
set -g clock-mode-style 12

# Right side of status bar
set -g status-right-length "100"
set -g status-right-style "bg=$BLUE,fg=$MANTLE"
set -g status-right "#[fg=$GREEN,bg=$MANTLE]#[fg=$MANTLE,bg=$GREEN] %I:%M %p #[fg=$BLUE,bg=$GREEN]#[fg=$MANTLE,bg=$BLUE,bold] %m-%d-%Y #[fg=$BLUE,bg=$MANTLE]" #

set -g window-status-separator ""
set -g window-status-current-style "bg=$MANTLE,fg=$BLUE"
set -g window-status-format "  #[fg=$BLUE,bg=$MANTLE,bold] #I #[fg=$GREEN,bg=$MANTLE,nobold] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev)  "
set -g window-status-current-format "#[fg=$BLUE,bg=$MANTLE] #[bg=$BLUE,fg=$MANTLE,bold] #I #[fg=$BLUE,bg=$GREEN,nobold]#[fg=$MANTLE,bg=$GREEN,nobold] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=$GREEN,bg=$MANTLE,nobold]#[bg=$MANTLE]"  #
set -g window-status-activity-style "bg=$MANTLE,fg=$BLUE"

#Pane border
set -g pane-border-style "bg=$MANTLE,fg=$MANTLE"
set -g pane-active-border-style "bg=$MANTLE,fg=$GREEN"
set -g pane-border-format " #P: #{pane_current_command} "

#Message
set -g message-style "bg=$BLUE,fg=$MANTLE"

#Command message
set -g message-command-style "bg=$MANTLE,fg=$MANTLE"

#Mode
set -g mode-style "bg=$MANTLE,fg=$MANTLE"
# ========================================================================== }}}
