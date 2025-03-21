#!/bin/bash

# Ensure necessary directories exist
mkdir -p ~/.config

# Symlink dotfiles
ln -sfn ~/dotfiles/aerospace ~/.config/aerospace
ln -sfn ~/dotfiles/wezterm ~/.config/wezterm
ln -sfn ~/dotfiles/zathura ~/.config/zathura
ln -sfn ~/dotfiles/starship ~/.config/starship
ln -sfn ~/dotfiles/karabiner ~/.config/karabiner
ln -sfn ~/dotfiles/tmux ~/.config/tmux
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/zsh/.zshrc ~/.zshrc

echo "Dotfiles setup complete!"
