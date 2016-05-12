#!/bin/bash
mkdir ./swap
mkdir ./undo
mkdir ./backup
mkdir ./bundle

git clone https://github.com/vundlevim/vundle.vim.git ./bundle/vundle
vim +PluginInstall +qall
