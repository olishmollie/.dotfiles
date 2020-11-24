#!/bin/sh

# Install development environment for macos.

set -e

echo "Copying dotfiles..."
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zhrc"
ln -s "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"
ln -s "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"

cp "$HOME/.dotfiles/profile.uninstall.sh" "$HOME"
cp -R "$HOME/.dotfiles/.vim/" "$HOME"

echo "Checking if Homebrew is installed..."

if ! which -s brew; then
    echo "Installing Homebrew..."
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
	brew tap homebrew/bundle
	brew bundle cleanup --force
fi

echo "Installing core packages..."
brew bundle

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global user.name "AJ Bond"
git config --global user.email "olishmollie@gmail.com"

echo "Configuring Vim..."
vim +PlugInstall +qall

echo "Configuring Emacs..."
git clone https://github.com/olishmollie/memacs "$HOME/.emacs.d"

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installation complete. Restart terminal to see changes."
echo "To uninstall, run ~/.dotfiles/uninstall.sh"
echo ""
