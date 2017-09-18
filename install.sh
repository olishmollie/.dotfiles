#!/usr/bin/env bash

# Copies and symlinks dotfiles into home folder

mv .vim ~
cp .gitignore_global ~
cp .gitconfig ~

ln -s ~/.profile/.bash_profile ~/.bash_profile
ln -s ~/.profile/.vimrc ~/.vimrc

cp .olishmollie.uninstall.sh ~
