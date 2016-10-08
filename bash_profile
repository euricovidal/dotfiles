#!/bin.bash
source $HOME/.bash/config # should be the first
source $HOME/.bash/paths
source $HOME/.bash/aliases
source $HOME/.bash/aliases_projects
source $HOME/.bash/completions
source $HOME/.bash/functions
#source $HOME/.bash/battery

hitch_now

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
