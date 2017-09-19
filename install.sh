#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

set -e

cp -R .vim ~
cp .gitignore_global ~
cp .gitconfig ~

ln -s ~/.profile/.bash_profile ~/.bash_profile
ln -s ~/.profile/.vimrc ~/.vimrc
ln -s ~/.profile/.inputrc ~/.inputrc
ln -s ~/.profile/.irbrc ~/.irbrc

cp olishmollie.uninstall.sh ~

# Installs vim plugins
vim +PlugInstall +qall 

echo 'Installation complete.'
echo 'Restart terminal to see changes.'
echo 'To uninstall, run olishmollie.uninstall.sh'
echo ''
