#!/bin/sh

# Install development environment for macos.

echo "Changing shell..."
chsh -s /bin/bash

echo "Copying dotfiles..."
ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"
cp -r "$HOME/.dotfiles/.config" "$HOME/.config"

echo "Checking if Homebrew is installed..."
if ! which -s brew; then
    echo "Installing Homebrew..."
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
	brew tap homebrew/bundle
	brew bundle --file $HOME/.dotfiles/Brewfile cleanup --force-r
fi

echo "Installing core packages..."
brew bundle --file $HOME/.dotfiles/Brewfile

echo "Installation complete. Restart terminal to see changes."
echo "To uninstall, run ~/.dotfiles/macos.uninstall.sh"
echo ""
