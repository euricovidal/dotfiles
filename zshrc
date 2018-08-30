export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell" #default
ZSH_THEME="wedisagree" # simple
#ZSH_THEME="miloshadzic" # simpliest

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
plugins=(zsh-autosuggestions git rails)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin:/opt/X11/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

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

# RVM
alias rvmg='rvm gemset'

# RailRoady
alias railroady_models='railroady -a -i -m -o models.dot -M ; dot -Tpng models.dot > models.png; rm models.dot'
alias railroady_controllers='railroady -C | neato -Tpng > controllers.png'

# TMUX
alias tmux='tmux -2'

# Git
alias gitrm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gst='git st'
alias gpr='git push && open-pr "$*"'

# Mongo DB
alias mongo-start='mongod run --dbpath /usr/local/Cellar/mongodb/ --rest'

# Memcache
alias memcache-start='/usr/local/bin/memcached -m 1024 -u root -l 127.0.0.1 -p 11211 –u nobody'

# PostGre
alias pg_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg_stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Underscore JQ
alias jq="~/dotfiles/bin/jq '.'"

# Vim
alias wpvim='cd wp-content/themes/ && vim . && cd ../../'

alias env='env | sort'
alias findd='find . -type d | grep -i '

alias gitcop="git diff --diff-filter=AM --name-only origin/master | ag '\.rb' | xargs rubocop"

#alias phploy='php /Library/WebServer/Documents/projects/phploy.phar'

# RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# to source syntax highlighting
source "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${ZSH_CUSTOM}/plugins/zsh-open-pr/git-open-pr.plugin.zsh"
source "${ZSH_CUSTOM}/plugins/zaw/zaw.zsh"

bindkey '^R' zaw-history
zstyle ':filter-select:highlight' matched fg=6
zstyle ':filter-select' max-lines 10
zstyle ':filter-select' case-insensitive yes
zstyle ':filter-select' rotate-list yes
zstyle ':filter-select' extended-search yes
zstyle ':filter-select' hist-find-no-dups yes
zstyle ':filter-select' escape-descriptions no

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red', 'sudo rm ' 'fg=white,bold,bg=red')
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

#export HOMEBREW_GITHUB_API_TOKEN="5b183411c6f8e073fe61db142d7fc8d8b58583f5"

# The next line updates PATH for the Google Cloud SDK.
#if [ -f /Users/euricovidal/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  #source '/Users/euricovidal/Downloads/google-cloud-sdk/path.zsh.inc'
#fi

# The next line enables shell command completion for gcloud.
#if [ -f /Users/euricovidal/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  #source '/Users/euricovidal/Downloads/google-cloud-sdk/completion.zsh.inc'
#fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/euricovidal/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/euricovidal/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/euricovidal/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/euricovidal/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
