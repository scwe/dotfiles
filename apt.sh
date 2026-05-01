#!/bin/bash
set -e

sudo apt install -y \
  gitk tmux zsh curl unzip gnome-terminal \
  fd-find ripgrep \
  build-essential \
  docker.io docker-compose-v2

# Ubuntu ships fd as `fdfind` to avoid a name collision; my init.lua's
# telescope find_command calls `fd`, so symlink it into ~/.local/bin.
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# GitHub CLI from the official apt repo (gh is not in the default
# Ubuntu repos). Setup steps from https://cli.github.com/manual/installation
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh

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

# FiraCode Nerd Font for terminal/neovim icons (lualine, nvim-web-devicons,
# neo-tree all assume a Nerd Font is on hand).
mkdir -p ~/.local/share/fonts
curl -L -o /tmp/FiraCode.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o /tmp/FiraCode.zip -d ~/.local/share/fonts/FiraCode
rm /tmp/FiraCode.zip
fc-cache -f

# Google Cloud SDK installed system-wide under /opt, alongside neovim.
curl -sSL https://sdk.cloud.google.com > /tmp/gcloud-install.sh
sudo bash /tmp/gcloud-install.sh --disable-prompts --install-dir=/opt
rm /tmp/gcloud-install.sh

sudo apt-get upgrade -y

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh
