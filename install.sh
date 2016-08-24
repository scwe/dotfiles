#!/bin/bash
mkdir ./swap
mkdir ./undo
mkdir ./backup
mkdir ./bundle

ln -sf ~/.vim/.vimrc ~/.vimrc
ln -sf ~/.vim/.tmux.conf ~/.tmux.conf
ln -sf ~/.vim/.zshrc ~/.zshrc

git clone https://github.com/vundlevim/vundle.vim.git ./bundle/Vundle.vim
vim +PluginInstall +qall
