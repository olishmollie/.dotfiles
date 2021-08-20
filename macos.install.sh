#!/bin/sh

# Install development environment for macos.

echo "Copying dotfiles..."
ln -s "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/.dotfiles/.gitignore_global" "$HOME/.gitignore_global"
ln -s "$HOME/.dotfiles/.inputrc" "$HOME/.inputrc"

echo "Checking if Homebrew is installed..."
if ! which -s brew; then
    echo "Installing Homebrew..."
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
	brew tap homebrew/bundle
	brew bundle --file $HOME/.dotfiles/Brewfile cleanup --force
fi

echo "Installing core packages..."
brew bundle --file $HOME/.dotfiles/Brewfile

echo "Configuring git..."
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global user.name "AJ Bond"
git config --global user.email "olishmollie@gmail.com"

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

echo "Installing fonts..."
cd $HOME/Library/Fonts &&
{
  curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o 'MesloLGS NF Regular.ttf'
  curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o 'MesloLGS NF Bold.ttf'
  curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o 'MesloLGS NF Italic.ttf'
  curl https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o 'MesloLGS NF Bold Italic.ttf'
  cd -
}

echo "Installing oh-my-zsh..."
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Installation complete. Restart terminal to see changes."
echo "To uninstall, run ~/.dotfiles/macos.uninstall.sh"
echo ""
