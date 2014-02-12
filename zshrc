# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME='babinho'

# Never know when you're gonna need to popd!
setopt AUTO_PUSHD

# Show completion on first tab
setopt menucomplete


# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew bundler zsh-syntax-highlighting ruby chruby)

source $ZSH/oh-my-zsh.sh

# Source my custom files after oh-my-zsh so I can override things.
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

# Show contents of directory after cd-ing into it
chpwd() {
  a
}

# Customize to your needs...
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

PATH=$HOME/.cask/bin:$PATH # Add cask to PATH

# chruby
#source /usr/local/opt/chruby/share/chruby/chruby.sh
#source /usr/local/opt/chruby/share/chruby/auto.sh

chruby ruby-2.0.0-p353

export PATH=$PATH:/usr/texbin

# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='vim'

# vim commands for the shell
set -o vi

source ~/bin/tmuxinator.zsh

# ruby GC tuning
export RUBY_GC_HEAP_INIT_SLOTS=2000000
export RUBY_HEAP_FREE_MIN=20000
export RUBY_GC_MALLOC_LIMIT=100000000

unsetopt correctall
setopt correct
