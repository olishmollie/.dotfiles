#!/bin/sh

# Copies dotfiles into home folder

set -e

cp -R .vim $HOME
cp -R .config $HOME
cp -R .passman $HOME

cp $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
cp $HOME/.dotfiles/.bashrc $HOME/.bashrc
cp $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
cp $HOME/.dotfiles/.gitignore_global $HOME/.gitignore_global
cp $HOME/.dotfiles/.inputrc $HOME/.inputrc
cp $HOME/.dotfiles/.irbrc $HOME/.irbrc
cp $HOME/.dotfiles/.spacemacs $HOME/.spacemacs
cp $HOME/.dotfiles/.vimrc $HOME/.vimrc

# Set global gitignore
git config --global core.excludesfile $HOME/.gitignore_global

cp olishmollie.uninstall.sh $HOME

# Install vim plugins
vim +PlugInstall +qall

echo 'Installation complete. Restart terminal to see changes.'
echo 'To uninstall, run olishmollie.uninstall.sh'
echo ''
