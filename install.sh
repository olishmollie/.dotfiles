#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

set -e

cp -R .vim $HOME

ln -s $HOME/.profile/.bash_profile $HOME/.bash_profile
ln -s $HOME/.profile/.vimrc $HOME/.vimrc
ln -s $HOME/.profile/.spacemacs $HOME/.spacemacs
ln -s $HOME/.profile/.inputrc $HOME/.inputrc
ln -s $HOME/.profile/.irbrc $HOME/.irbrc
ln -s $HOME/.profile/.gitignore_global $HOME/.gitignore_global
ln -s $HOME/.profile/.gitconfig $HOME/.gitconfig

# Sets global gitignore
git config --global core.excludesfile $HOME/.gitignore_global

cp olishmollie.uninstall.sh ~

# Installs vim plugins
vim +PlugInstall +qall

echo 'Installation complete.'
echo 'Restart terminal to see changes.'
echo 'To uninstall, run olishmollie.uninstall.sh'
echo ''
