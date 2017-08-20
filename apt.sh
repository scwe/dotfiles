#!/bin/bash
sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y g++
sudo apt-get install -y git
sudo apt-get install -y gitk
sudo apt-get install -y pgadmin3
sudo apt-get install -y tmux
sudo apt-get install -y vim-gtk
sudo apt-get install -y zsh
sudo apt-get install -y python3-dev
sudo apt-get install -y python-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y curl
sudo apt-get install -y gnome-terminal

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update

sudo apt-get install -y sublime-text-installer
sudo apt-get install -y mono-complete

# Install nodejs
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install -y nodejs

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

# install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

pip install jedi
sudo npm install -g tern-node-express
sudo npm install -g standard
sudo npm install -g nodemon

sudo apt-get upgrade


sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh

echo "Don't forget to manually install Steam, Chrome, Atom, sublime, code"
