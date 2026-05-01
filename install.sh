#!/bin/bash
mkdir -p ./swap ./undo ./backup ./bundle

# Remove the auto created zshrc
rm -rf ~/.zshrc

# link configs
ln -sf ~/.vim/.vimrc ~/.vimrc
ln -sf ~/.vim/.vscodevimrc ~/.vscodevimrc
ln -sf ~/.vim/.tmux.conf ~/.tmux.conf
ln -sf ~/.vim/.zshrc ~/.zshrc
ln -sf ~/.vim/.zshenv ~/.zshenv

# Neovim
mkdir -p ~/.config/nvim
ln -sf ~/.vim/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/.vim/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

# Git
ln -sf ~/.vim/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf ~/.vim/git/ignore ~/.config/git/ignore

# Claude Code (CLAUDE.md and settings.json only — credentials, history,
# and runtime state stay machine-local)
mkdir -p ~/.claude
ln -sf ~/.vim/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.vim/claude/settings.json ~/.claude/settings.json

git clone https://github.com/vundlevim/vundle.vim.git ./bundle/Vundle.vim
vim +PluginInstall +qall

cp -r ~/.vim/bundle/molokai/colors ~/.vim/colors


# Install you complete me for Vim
python3 ./bundle/youcompleteme/install.py
