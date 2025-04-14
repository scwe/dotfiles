#!/bin/bash
sudo apt install -y gitk vim vim-gtk3 tmux zsh curl gnome-terminal direnv cmake

# Install nodejs
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install -y nodejs


# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

nvm install 20.11
npm install --global yarn

# Install pyenv
curl -fsSL https://pyenv.run | bash

sudo apt-get upgrade

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh
