#!/usr/bin/env bash

# Copies dotfiles into home folder

set -e

cp -R .vim $HOME

cp $HOME/dotfiles/.bash_profile $HOME/.bash_profile
cp $HOME/dotfiles/.vimrc $HOME/.vimrc
cp $HOME/dotfiles/.spacemacs $HOME/.spacemacs
cp $HOME/dotfiles/.inputrc $HOME/.inputrc
cp $HOME/dotfiles/.irbrc $HOME/.irbrc
cp $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global
cp $HOME/dotfiles/.gitconfig $HOME/.gitconfig
cp $HOME/dotfiles/.bashrc $HOME/.bashrc

# Sets global gitignore
git config --global core.excludesfile $HOME/.gitignore_global

cp olishmollie.uninstall.sh ~

# Installs vim plugins
vim +PlugInstall +qall

echo 'Installation complete.'
echo 'Remember to set git user/email with `git config --global`'
echo 'Restart terminal to see changes.'
echo 'To uninstall, run olishmollie.uninstall.sh'
echo ''
