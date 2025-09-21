#!/bin/bash

# Setup script for dotfiles

echo "Setting up dotfiles..."

# Install zsh configuration
stow -t ~ zsh

# Install other configurations
stow -t ~ nvim
stow -t ~ git
stow -t ~ tmux
stow -t ~ wezterm
stow -t ~ ranger
stow -t ~ ncmpcpp

# Initialize submodules if they exist
if [ -f .gitmodules ]; then
    echo "Initializing git submodules..."
    git submodule update --init --recursive
fi

echo "Setup complete!"
echo ""
echo "Note: Make sure oh-my-zsh is installed at ~/.oh-my-zsh"
echo "Install with: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""