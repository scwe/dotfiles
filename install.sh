#!/bin/bash
set -e

# Remove the auto-created zshrc so the symlink below can take its place
rm -f ~/.zshrc

# Shell + tmux
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

# Bootstrap neovim plugins (lazy.nvim auto-clones itself on first run, then
# this headless invocation installs everything from lazy-lock.json).
nvim --headless "+Lazy! sync" +qa
