#!/bin/bash
sudo apt install -y gitk vim vim-gtk3 tmux zsh curl gnome-terminal cmake

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
