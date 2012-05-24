#!/bin/bash

ln -s .vim/vimrc ~/.vimrc
ln -s .vim/dotctags ~/.ctags
ln -s .vim/jshintrc ~/.jshintrc

cd ~/.vim
git submodule update --init --recursive

