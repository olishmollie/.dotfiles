#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

set -e

cp -R .vim ~
cp .gitignore_global ~
cp .gitconfig ~

ln -s ~/.profile/.bash_profile ~/.bash_profile
ln -s ~/.profile/.vimrc ~/.vimrc

cp .olishmollie.uninstall.sh ~

# Installs vim plugins
vim +PlugInstall +qall 

# Add colorscheme
echo '' >> ~/.vimrc
echo 'colorscheme monokai' >> ~/.vimrc

echo 'Installation complete.'
echo 'To uninstall, run .olishmollie.uninstall.sh'
echo ''
