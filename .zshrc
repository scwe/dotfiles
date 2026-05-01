# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="steeef"

plugins=(git command-not-found python sudo tmux)

source $ZSH/oh-my-zsh.sh

path+=('/home/scott/bin')       #For executables that I want to keep locally
path+=('/home/scott/.local/bin')        #For ihaskell and stack installed executables
path+=('/home/scott/node_modules/.bin')
path+=('/opt/nvim-linux-x86_64/bin')  # For neovim

export PATH

fpath=( ~/.vim/funcs "${fpath[@]}" )

export FPATH

alias python=python3
alias pip=pip3
alias vim=nvim

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/scott/Tools/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/scott/Tools/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/scott/Tools/google-cloud-sdk/completion.zsh.inc ]; then

  source '/home/scott/Tools/google-cloud-sdk/completion.zsh.inc'
fi

# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Auto-switch node version on cd based on .nvmrc (from nvm's README).
# Installs the version if missing, reverts to default when leaving an .nvmrc tree.
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

autoload store
autoload old-boy
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# pnpm
export PNPM_HOME="/home/scott/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
