# Cross-Platform Dotfiles

This repository uses GNU Stow to manage dotfiles across multiple platforms with a modular approach. Each directory (software, platforms, hosts) contains a `.stowrc` file that sets the target directory to `$HOME`.

## Directory Structure

```
dotfiles/
├── software/         # All software packages
│   ├── git/          # Git configuration (home directory files)
│   ├── zsh/          # Zsh configuration (home directory files)
│   ├── nvim/         # Neovim configuration
│   ├── tmux/         # Tmux configuration
│   ├── nvm/          # NVM configuration (shell integration)
│   ├── fzf/          # FZF configuration (shell integration)
│   ├── docker/       # Docker configuration (shell integration)
│   ├── bat/          # Bat configuration
│   └── wezterm/      # Wezterm configuration
├── platforms/        # Platform-specific configurations
│   ├── linux/        # Linux-specific settings
│   └── darwin/       # macOS-specific settings
└── hosts/            # Host-specific configurations
    └── hostname/     # Create directory with your hostname
```

## Package Organization

Packages are organized in two ways:

1. **Home directory packages** (git, zsh): Store files directly in `~/` (e.g., `~/.gitconfig`, `~/.zshrc`)
2. **Config directory packages** (nvim, tmux, bat, wezterm): Use `.config/` structure (e.g., `~/.config/nvim/`)
3. **Shell integration packages** (nvm, fzf, docker): Minimal `.zshrc.d/` files for shell setup

## Installation

### Base Setup
```bash
# Install basic configurations
cd software && stow --dotfiles zsh nvim tmux git
```

### Optional Software
```bash
# Install additional packages
cd software && stow --dotfiles bat      # Cat clone with syntax highlighting
cd software && stow --dotfiles wezterm  # Terminal emulator configuration
cd software && stow --dotfiles fzf      # Fuzzy finder
cd software && stow --dotfiles nvm      # Node version manager
cd software && stow --dotfiles docker   # Docker aliases and functions
```

### Platform-Specific
```bash
# Linux
cd platforms && stow --dotfiles linux

# macOS
cd platforms && stow --dotfiles darwin
```

### Host-Specific
```bash
# Replace 'hostname' with your actual hostname
cd hosts && stow --dotfiles hostname
```

## ZSH Modular Configuration

The zsh configuration is modular - files in `~/.zshrc.d/` are loaded automatically in numerical order. Each software package adds its own configuration file when stowed:

- `00-base.zsh` - Powerlevel10k and key bindings
- `05-bubbles.zsh` - Powerlevel10k bubble theme
- `10-aliases.zsh` - General aliases
- `15-linux.zsh` or `15-darwin.zsh` - Platform-specific
- `20-fzf.zsh` - FZF configuration (when fzf package is stowed)
- `25-docker.zsh` - Docker configuration (when docker package is stowed)
- `30-tools.zsh` - Various tool configurations
- `40-nvm.zsh` - NVM configuration (when nvm package is stowed)
- `50-exports.zsh` - Environment variables
- `60-completion.zsh` - Zsh completion settings
- `99-hostname.zsh` - Host-specific (when hostname package is stowed)

## Features

- **Clean separation**: Each software configuration is isolated
- **Modular**: Only install what you need
- **Platform-aware**: Platform-specific configurations when needed
- **Host-specific**: Override settings for specific machines
- **Simple stow usage**: No complex arguments or install scripts