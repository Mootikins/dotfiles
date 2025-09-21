# Installation Guide

## New Structure Overview

Your dotfiles are now organized by function:

- **shell/** - Shell configurations (zsh, bash)
  - zsh/.zshrc and modular zshrc.d/* files
- **wm/** - Window manager and desktop configs (i3, polybar, rofi, dunst)
- **term/** - Terminal emulators (wezterm, tmux)
- **edit/** - Text editors (nvim)
- **tools/** - Various tools (git, bat, btop, ranger, ncmpcpp)
- **shared/** - Shared configurations (X11, formatters)
- **scripts/** - Standalone scripts

## Installation

### Install all configurations
```bash
stow -t ~ shell wm term edit tools shared
```

### Install specific categories
```bash
# Just shell configurations
stow -t ~ shell

# Just window manager
stow -t ~ wm

# Just terminal configs
stow -t ~ term

# Just editor configs
stow -t ~ edit

# Just tool configs
stow -t ~ tools
```

### Uninstall configurations
```bash
stow -D -t ~ shell  # Uninstall shell configs
```

## Zsh Modular Configuration

The zsh configuration is now modular:
- `~/.zshrc.d/00-exports.sh` - Environment variables
- `~/.zshrc.d/01-aliases.sh` - Command aliases
- `~/.zshrc.d/02-functions.sh` - Custom functions
- `~/.zshrc.d/03-plugins.sh` - Plugin configurations
- `~/.zshrc.d/99-local.sh` - Local overrides (not tracked)

Add your own files in ~/.zshrc.d/ with numeric prefixes for load order.