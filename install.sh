#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

set -e

cp -R .vim $HOME

cp $HOME/.profile/.bash_profile $HOME/.bash_profile
cp $HOME/.profile/.vimrc $HOME/.vimrc
cp $HOME/.profile/.spacemacs $HOME/.spacemacs
cp $HOME/.profile/.inputrc $HOME/.inputrc
cp $HOME/.profile/.irbrc $HOME/.irbrc
cp $HOME/.profile/.gitignore_global $HOME/.gitignore_global

# Sets global gitignore
git config --global core.excludesfile $HOME/.gitignore_global

cp olishmollie.uninstall.sh ~

# Installs vim plugins
vim +PlugInstall +qall

echo 'Installation complete.'
echo 'Restart terminal to see changes.'
echo 'To uninstall, run olishmollie.uninstall.sh'
echo ''
