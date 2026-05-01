# scott's dotfiles

## Fresh machine setup (Ubuntu)

Bootstrap a new machine in one shot — system packages, language toolchains, neovim, and every dotfile symlinked into place.

```sh
sudo apt install -y git
git clone https://github.com/scwe/dotfiles.git ~/.vim
cd ~/.vim
chmod +x bootstrap.sh apt.sh install.sh
./bootstrap.sh
```

After `bootstrap.sh` finishes:

- Log out and back in so zsh becomes the default shell.
- `gh auth login` — GitHub CLI.
- `gcloud auth login` — Google Cloud SDK.
- `claude` — Claude Code.

## What's in here

- `apt.sh` — system packages, neovim release tarball, nvm + node, yarn, uv, gh, docker, gcloud, oh-my-zsh, Nerd Font
- `install.sh` — symlinks every config file into the right home-directory location and pre-installs neovim plugins (`Lazy! sync`)
- `bootstrap.sh` — runs `apt.sh` then `install.sh`
- `nvim/` — `init.lua` + `lazy-lock.json` (→ `~/.config/nvim/`)
- `claude/` — `CLAUDE.md` + `settings.json` (→ `~/.claude/`)
- `git/ignore` — global gitignore (→ `~/.config/git/ignore`)
- `funcs/` — small zsh autoload functions (`store`, `old-boy`)
- `.zshrc`, `.zshenv`, `.tmux.conf`, `.vscodevimrc`, `.gitconfig` — shell, multiplexer, vscode-vim, git
