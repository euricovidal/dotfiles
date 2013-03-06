#!/bin.bash
alias gst="git status"
source $HOME/.bash/paths
source $HOME/.bash/config
source $HOME/.bash/aliases
source $HOME/.bash/aliases_projects
source $HOME/.bash/completions
source $HOME/.bash/functions
#source $HOME/.bash/battery
#source $HOME/.bash/funcoeszz
export ZZOFF=""  # desligue funcoes indesejadas
export ZZDIR=$HOME/Dotfiles/funcoeszz/zz
export ZZPATH=$HOME/Dotfiles/funcoeszz/funcoeszz  # script
source $ZZPATH

gem list hitch | grep -i "hitch" &>/dev/null
if [ $? -eq 0 ]; then
  hitch() {
    command hitch "$@"
      if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
  }
  alias unhitch='hitch -u'
  hitch
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*