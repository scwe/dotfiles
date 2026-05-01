#!/bin/bash
set -e

sudo apt install -y \
  gitk tmux zsh curl gnome-terminal \
  fd-find ripgrep \
  build-essential \
  docker.io docker-compose-v2

# Ubuntu ships fd as `fdfind` to avoid a name collision; my init.lua's
# telescope find_command calls `fd`, so symlink it into ~/.local/bin.
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# Neovim from the official release tarball — matches the /opt/nvim-linux-x86_64
# path that .zshrc already adds to PATH. Apt's neovim is usually a major
# version behind, which my init.lua plugins don't appreciate.
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

nvm install --lts
npm install --global yarn

# Install uv (Python package + project manager, also handles Python versions)
curl -LsSf https://astral.sh/uv/install.sh | sh

sudo apt-get upgrade -y

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh
