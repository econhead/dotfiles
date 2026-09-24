#!/bin/bash

# Ensure necessary directories exist
mkdir -p ~/.config ~/.local/state/noctalia

# Symlink dotfiles
ln -sfn ~/.dotfiles/aerospace ~/.config/aerospace
ln -sfn ~/.dotfiles/wezterm ~/.config/wezterm
ln -sfn ~/.dotfiles/zathura ~/.config/zathura
ln -sfn ~/.dotfiles/starship ~/.config/starship
ln -sfn ~/.dotfiles/karabiner ~/.config/karabiner
ln -sfn ~/.dotfiles/tmux ~/.config/tmux
ln -sfn ~/.dotfiles/nvim ~/.config/nvim
ln -sfn ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/.dotfiles/ghostty ~/.config/ghostty
ln -sfn ~/.dotfiles/kitty ~/.config/kitty
ln -sfn ~/.dotfiles/hypr ~/.config/hypr
ln -sfn ~/.dotfiles/fastfetch ~/.config/fastfetch
ln -sfn ~/.dotfiles/sioyek ~/.config/sioyek
ln -sfn ~/.dotfiles/xremap ~/.config/xremap
ln -sfn ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -sfn ~/.dotfiles/noctalia/settings.toml ~/.local/state/noctalia/settings.toml
ln -sfn ~/.dotfiles/qutebrowser ~/.config/qutebrowser

echo "Dotfiles setup complete!"
