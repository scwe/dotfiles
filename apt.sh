#!/bin/bash
sudo apt-get install -y gitk
sudo apt-get install -y tmux
sudo apt-get install -y zsh
sudo apt-get install -y curl
sudo apt-get install -y gnome-terminal

# Install nodejs
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install -y nodejs


# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash


sudo apt-get upgrade

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
chsh -s /bin/zsh

echo "Don't forget to manually install Steam, Chrome, Atom, sublime, code"
