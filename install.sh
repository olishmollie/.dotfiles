#!/bin/sh

# Copies dotfiles into home folder, installs software I use

set -e

echo "Copying dotfiles..."
cp -R "$HOME/.dotfiles/.vim" "$HOME"
cp -R "$HOME/.dotfiles/.vscode" "$HOME"
cp "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
cp "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
cp "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
cp "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
cp "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"
cp "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
cp "$HOME/.dotfiles/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
cp "$HOME/.dotfiles/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

echo "Copying uninstall script"
cp "$HOME/.dotfiles/profile.uninstall.sh" "$HOME"

echo "Installing vim plugins"
vim +PlugInstall +qall

echo "Installing Rust"
curl https://sh.rustup.rs -sSf | sh

echo "Intalling Homebrew"
yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install bash
brew install git
brew install go
brew install python
brew install olishmollie/tools/fig
brew install olishmollie/tools/nconv
brew install olishmollie/tools/passman

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"

echo "Changing default shell..."
sudo cp /etc/shells /etc/shells~old
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash

echo "Installation complete. Restart terminal to see changes."

# WARNING: The next line must be in raw ('') quotes
echo 'To uninstall, run `~/profile.uninstall.sh`'

echo ""
