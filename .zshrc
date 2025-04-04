# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="steeef"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-not-found python sudo tmux direnv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

path+=('/home/scott/bin')       #For executables that I want to keep locally
path+=('/home/scott/anaconda3/bin')     #For anaconda related scripts
path+=('/home/scott/.local/bin')        #For ihaskell and stack installed executables
path+=('/home/scott/node_modules/.bin')
path+=('/usr/local/cuda-8.0/bin')

export PATH

fpath=( ~/.vim/funcs "${fpath[@]}" )

export FPATH

#LD_LIBRARY_PATH=('/usr/local/cuda-8.0/lib64')
#LD_LIBRARY_PATH+=('/home/scott/Projects/Libraries/cuda')
#LD_LIBRARY_PATH+=('/home/scott/Projects/Libraries/cuda/lib64')

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64:/home/scott/Projects/Libraries/cuda:/home/scott/Projects/Libraries/cuda/lib64
#export LD_LIBRARY_PATH

#CUDA_HOME+=('/home/scott/Projects/Libraries/cuda')

#export CUDA_HOME="/home/scott/Projects/Libraries/cuda"
#export CUDA_HOME

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias python=python3
alias pip=pip3

# alias tmux='TERM=xterm-256color tmux -2'
alias vim='TERM=screen-256color vim'

# So that steam fucking works....
# alias steam='LD_LIBRARY_PATH=~/steamlibs/ steam'

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

autoload store
autoload old-boy
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Direnv doesn't play super nicely with TMUX https://github.com/direnv/direnv/issues/106
if [ -n "$TMUX" ] && [ -n "$DIRENV_DIR" ]; then
      unset -m "DIRENV_*"  # unset env vars starting with DIRENV_
fi
eval "$(direnv hook bash)"
