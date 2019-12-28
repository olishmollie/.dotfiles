#!/bin/sh

# Installs my development environment for macos.

set -e

echo "Copying dotfiles..."
mkdir "$HOME/.emacs.d/"
cp -R "$HOME/.dotfiles/.vim/" "$HOME"

ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"
ln -s "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/.dotfiles/init.el" "$HOME/.emacs.d/init.el"
ln -s "$HOME/.dotfiles/core.el" "$HOME/.emacs.d/core.el"

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
brew install clang-format
brew install node

brew cask install emacs

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

echo "To uninstall, run ~/profile.uninstall.sh"
echo ""
