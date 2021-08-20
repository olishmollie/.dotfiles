#!/bin/sh

# Install development environment for macos.

echo "Copying dotfiles..."
ln -bs "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -bs "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -bs "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -bs "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -bs "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"

echo "Installing core packages..."
sudo apt -y update && sudo apt -y upgrade
sudo apt install -y emacs
sudo apt install -y shellcheck

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global user.name "AJ Bond"
git config --global user.email "olishmollie@gmail.com"

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Installation complete. Restart terminal to see changes."
echo "To uninstall, run ~/.dotfiles/uninstall.sh"
echo ""
