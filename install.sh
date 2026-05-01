#!/bin/bash
set -e

# Remove the auto-created zshrc so the symlink below can take its place
rm -f ~/.zshrc

# Shell + tmux
ln -sf ~/.vim/.vscodevimrc ~/.vscodevimrc
ln -sf ~/.vim/.tmux.conf ~/.tmux.conf
ln -sf ~/.vim/.zshrc ~/.zshrc
ln -sf ~/.vim/.zshenv ~/.zshenv

# Home-level editorconfig (anything outside a project with its own picks this up)
ln -sf ~/.vim/.editorconfig ~/.editorconfig

# Neovim
mkdir -p ~/.config/nvim
ln -sf ~/.vim/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/.vim/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json

# Git
ln -sf ~/.vim/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf ~/.vim/git/ignore ~/.config/git/ignore

# SSH host aliases (keys themselves stay machine-local)
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ln -sf ~/.vim/ssh/config ~/.ssh/config

# Ghostty terminal config
mkdir -p ~/.config/ghostty
ln -sf ~/.vim/ghostty/config ~/.config/ghostty/config

# Claude Code (CLAUDE.md and settings.json only — credentials, history,
# and runtime state stay machine-local)
mkdir -p ~/.claude
ln -sf ~/.vim/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.vim/claude/settings.json ~/.claude/settings.json

# Make every tool the rest of this script (and the smoke test below) needs
# reachable. The relevant rc files (.zshrc, ~/.bashrc) won't have been
# sourced yet when install.sh runs as a script, so do the equivalent here.
export PATH="/opt/nvim-linux-x86_64/bin:$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Bootstrap neovim plugins (lazy.nvim auto-clones itself on first run, then
# this headless invocation installs everything from lazy-lock.json).
nvim --headless "+Lazy! sync" +qa

# Smoke test: every tool the rest of my workflow assumes is on PATH.
echo
echo "==> Smoke test"
errors=0
check() {
  if command -v "$1" >/dev/null 2>&1; then
    printf "  ok      %-8s %s\n" "$1" "$(eval "$2")"
  else
    printf "  MISSING %s\n" "$1"
    errors=$((errors + 1))
  fi
}
check nvim   "nvim --version | head -1"
check node   "node --version"
check npm    "npm --version"
check uv     "uv --version"
check fd     "fd --version"
check rg     "rg --version | head -1"
check gh     "gh --version | head -1"
check docker "docker --version"
check git    "git --version"
check jq     "jq --version"

if email=$(git config --get user.email 2>/dev/null); then
  printf "  ok      %-8s %s\n" "git" "user.email = $email"
else
  printf "  MISSING git user.email\n"
  errors=$((errors + 1))
fi

if [ "$errors" -gt 0 ]; then
  echo "$errors check(s) failed"
  exit 1
fi
echo "All checks passed."
