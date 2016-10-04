#!/bin/bash
mkdir ./swap
mkdir ./undo
mkdir ./backup
mkdir ./bundle

ln -sf ~/.vim/.vimrc ~/.vimrc
ln -sf ~/.vim/.tmux.conf ~/.tmux.conf
ln -sf ~/.vim/.zshrc ~/.zshrc
ln -sf ~/.vim/.tern-config ~/.tern-config

git clone https://github.com/vundlevim/vundle.vim.git ./bundle/Vundle.vim
vim +PluginInstall +qall

# Install you complete me for Vim
apt-get install build-essential cmake python3-dev python-dev
pip install jedi
npm install tern-node-express

./bundle/youcompleteme/install.py --clang-completer --tern-completer --omnisharp-completer

