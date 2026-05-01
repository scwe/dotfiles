#!/bin/bash
set -e

sudo apt install -y \
  gitk tmux zsh curl unzip gnome-terminal \
  fd-find ripgrep jq \
  htop btop nvtop \
  build-essential ca-certificates \
  apt-transport-https gnupg2 \
  net-tools wireguard-tools xclip openssh-server \
  redis-tools

# Ubuntu ships fd as `fdfind` to avoid a name collision; my init.lua's
# telescope find_command calls `fd`, so symlink it into ~/.local/bin.
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# Docker CE from Docker's official apt repo (newer than Ubuntu's docker.io).
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Run docker without sudo (effective after next login).
sudo usermod -aG docker "$USER"

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

# VSCode (Microsoft's apt repo)
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/packages.microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
  | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo apt update
sudo apt install -y code

# Google Chrome (Google's apt repo)
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
  | sudo gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
sudo apt update
sudo apt install -y google-chrome-stable

# Pritunl client (work VPN). Steps from https://docs.pritunl.com/docs/installation
echo "deb https://repo.pritunl.com/stable/apt $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/pritunl.list > /dev/null
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A \
  | sudo tee /etc/apt/trusted.gpg.d/pritunl.asc > /dev/null
sudo apt update
sudo apt install -y pritunl-client-electron

# Neovim from the official release tarball — matches the /opt/nvim-linux-x86_64
# path that .zshrc already adds to PATH. Apt's neovim is usually a major
# version behind, which my init.lua plugins don't appreciate.
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz

# Install nvm. The installer appends sourcing logic to ~/.bashrc / ~/.zshrc
# but doesn't modify *this* shell, so explicitly source it before using nvm.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"

nvm install --lts
npm install --global yarn
npm install --global @anthropic-ai/claude-code

# Install uv (Python package + project manager, also handles Python versions)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Ghostty terminal (no official apt repo as of writing, snap is the most
# reliable cross-distro path on Ubuntu). --classic for tty/pty access.
sudo snap install ghostty --classic

# k9s (kubernetes TUI, not in Ubuntu repos — using the release tarball)
curl -L https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz \
  -o /tmp/k9s.tar.gz
sudo tar -xzf /tmp/k9s.tar.gz -C /usr/local/bin k9s
rm /tmp/k9s.tar.gz

# MongoDB Community Server from MongoDB's apt repo
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc \
  | sudo gpg --dearmor -o /etc/apt/keyrings/mongodb-server-7.0.gpg
echo "deb [ arch=amd64 signed-by=/etc/apt/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/7.0 multiverse" \
  | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list > /dev/null
sudo apt update
sudo apt install -y mongodb-org

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

# Two oh-my-zsh community plugins worth pulling in: autosuggestions
# (history-aware ghost-text completions) and syntax-highlighting (live
# command coloring). Both need to be cloned into custom/plugins; the
# .zshrc plugins=() line already references them.
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

chsh -s /bin/zsh
