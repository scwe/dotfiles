#!/bin/bash
mkdir ./swap
mkdir ./undo
mkdir ./backup
mkdir ./bundle

# link configs
ln -sf ~/.vim/.vimrc ~/.vimrc
ln -sf ~/.vim/.tmux.conf ~/.tmux.conf
ln -sf ~/.vim/.zshrc ~/.zshrc
ln -sf ~/.vim/.tern-config ~/.tern-config
ln -sf ~/.vim/.zshenv ~/.zshenv

git clone https://github.com/vundlevim/vundle.vim.git ./bundle/Vundle.vim
vim +PluginInstall +qall

cp -r ~/.vim/bundle/molokai/colors ~/.vim/colors


# Install you complete me for Vim
python3 ./bundle/youcompleteme/install.py --clang-completer --tern-completer --omnisharp-completer
