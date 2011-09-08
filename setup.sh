#!/bin/bash

ln -s .vim/vimrc ~/.vimrc
ln -s .vim/dotctags ~/.ctags

cd ~/.vim
git submodule init
git submodule update

