#!/bin/sh

# Install development environment for debian.

set -e

if [ $(pwd) != "/home/$(whoami)/.dotfiles" ]; then
    echo "$(pwd)"
    echo "Dotfiles repo should be installed in home directory."
    exit 1
fi

echo "Copying dotfiles..."
cp "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
cp "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
cp "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
cp "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global user.name "Andy Bond"
git config --global user.email "olishmollie@gmail.com"

echo "Installation complete. Restart terminal to see changes."
echo ""
