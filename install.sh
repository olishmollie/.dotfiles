#!/bin/sh

# Installs my development environment for macos.

set -e

echo "Copying dotfiles..."
cp -R "$HOME/.dotfiles/.vim/" "$HOME"
ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"
ln -s "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"

echo "Copying uninstall script..."
cp "$HOME/.dotfiles/profile.uninstall.sh" "$HOME"

echo "Intalling Homebrew..."
yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing important Homebrew packages..."
brew install bash
brew install clang-format
brew install git
brew install go
brew install node
brew install olishmollie/tools/fig
brew install olishmollie/tools/nconv
brew install olishmollie/tools/passman
brew install python
brew cask install emacs

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"

echo "Configuring Vim..."
vim +PlugInstall +qall

echo "Configuring Emacs..."
git clone https://github.com/olishmollie/memacs "$HOME/.emacs.d"

echo "Changing default shell..."
sudo cp /etc/shells /etc/shells~old
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/bash

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Installation complete. Restart terminal to see changes."
echo "To uninstall, run ~/profile.uninstall.sh"
echo ""
