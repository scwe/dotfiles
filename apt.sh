#!/bin/bash
sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y g++
sudo apt-get install -y git
sudo apt-get install -y gitk
sudo apt-get install -y pgadmin3
sudo apt-get install -y tmux
sudo apt-get install -y vim
sudo apt-get install -y zsh
sudo apt-get install -y python3-dev
sudo apt-get install -y python-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update

sudo apt-get install -y mono-complete

# Install nodejs
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

pip install jedi
sudo npm install -g tern-node-express
sudo npm install -g standard
sudo npm install -g nodemon

sudo apt-get upgrade

echo "Don't forget to manually install Steam, Chrome, Atom, sublime, code"
