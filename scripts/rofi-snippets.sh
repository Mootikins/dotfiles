#!/usr/bin/env bash

snippet_file="$(find ~/dotfiles/rofi-snippets/ -type f | rofi -dmenu -config ~/.config/rofi/rofidmenu.rasi)"

xclip -selection clipboard < "$snippet_file"
