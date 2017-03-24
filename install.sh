#!/bin/bash
HERE=`pwd`
BKP_PATH=$HERE/tmp/backup
GREEN="\e[1;32m"
NO_COLOR="\e[0m"
OSX=$(uname -a | grep -o "^Darwin")

function log() {
  local type=$1
  local msg=$2

  if [ "$type" == "info" ]; then
    printf "\e[1;37m  $msg $NO_COLOR"
  fi

  if [ "$type" == "success" ]; then
    printf "$GREEN ✓ $msg $NO_COLOR"
  fi

  if [ "$type" == "error" ]; then
    printf "\e[31m ✗ $msg $NO_COLOR"
  fi

  if [ "$msg" == "" ]; then
    printf "$GREEN $type $NO_COLOR"
  fi
}

clear
log "☕  INSTALL DOTFILES"
echo "\n"
log "Use github [Y/n]:"
read GITHUB

if [ "$GITHUB" == "Y" ] || [ "$GITHUB" == "y" ] || [ "$GITHUB" == "" ]; then
	log "Enter your name:"
	read NAME
	log "Enter your email on github:"
	read GIT_EMAIL
fi

log "Use ruby [Y/n]:"
read RUBY

log "Use zsh [Y/n]:"
read ZSH

log "Use vim [Y/n]:"
read VIM

log "Use tmux [Y/n]: "
read TMUX

if [ "$TMUX" != "n" ]; then
	log "Simple tmux config (if no, will be set the pretty config) [Y/n]: "
	read TMUX_SIMPLE
fi

if [ "$GIT_EMAIL" == "" ] && [ "$RUBY" == "n" ] && [ "$ZSH" == "n" ] && [ "$TMUX" == "n" ] && [ "$VIM" == "n" ]; then
	log "error" "Do nothing, bye..."
	exit
fi

echo "\n"
log "info" "CONFIRM:"
echo "\n"

[ "$GIT_EMAIL" != "" ] && log "info" "\t- Set GitHub (email: $GIT_EMAIL)\n"
[ "$RUBY" != "n" ] && log "info" "\t- Set Ruby configs\n"
[ "$ZSH" != "n" ] && log "info" "\t- Install ZSH and set configs\n"
[ "$VIM" != "n" ] && log "info" "\t- Install Vim and set configs\n"
if [ "$TMUX" != "n" ]; then
	if [ "$TMUX_SIMPLE" != "n" ]; then
		log "info" "\t- Install TMUX and set simple configs\n"
	else
		log "info" "\t- Install TMUX and set pretty configs\n"
	fi
fi

echo "\n"

log "It's ok? (if ins't setup will be aborted) [Y/n]"
read OK

[ "$OK" = "n" ] && exit

rm -rf $BKP_PATH
mkdir -p $BKP_PATH

if [ "$GIT_EMAIL" != "" ]; then
	sed -i '' "s/GIT_NAME/$NAME/" $HERE/gitconfig
	sed -i '' "s/GIT_EMAIL/$GIT_EMAIL/" $HERE/gitconfig
	log "info" "Moving git configs to tmp/backup\n"
	mv -f $HOME/.gitconfig $HOME/.gitignore $BKP_PATH
	log "info" "Seting new configs to git\n"
	ln -s -f $HERE/gitconfig $HOME/.gitconfig
	ln -s -f $HERE/gitignore $HOME/.gitignore
fi

if [ "$RUBY" != "n" ]; then
	log "info" "Moving ruby configs to tmp/backup\n"
	mv -f $HOME/.irbrc $HOME/.gemrc $HOME/.rspec  $BKP_PATH
	log "info" "Seting new configs to ruby\n"
	ln -s -f $HERE/inputrc $HOME/.inputrc
	ln -s -f $HERE/gemrc $HOME/.gemrc
	ln -s -f $HERE/rspec $HOME/.rspec
	ln -s -f $HERE/irbrc $HOME/.irbrc
fi

if [ "$ZSH" != "n" ]; then
	log "info" "Moving zsh configs to tmp/backup\n"
	mv -f $HOME/.zshrc $BKP_PATH
	if [ "$ZSH_VERSION" == "" ]; then
		log "info" "After all steps will be installed zsh\n"
	fi
	mkdir -p ~/.oh-my-zsh/custom/plugins
	git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
	git clone https://github.com/caarlos0/zsh-open-pr.git ~/.oh-my-zsh/custom/plugins/zsh-open-pr
	git clone git://github.com/zsh-users/zaw.git ~/.oh-my-zsh/custom/plugins/zaw
	log "info" "Seting new configs to zsh\n"
	ln -s -f $HERE/zshrc $HOME/.zshrc
else
	log "info" "Moving bash configs to tmp/backup\n"
	mv -f $HOME/.bash $HOME/.bash_history $BKP_PATH
	log "info" "Seting new configs to bash\n"
	ln -s -f $HERE/bash_profile $HOME/.bash_profile
	ln -s -f $HERE/bash_profile $HOME/.bashrc
	ln -s -f $HERE/bash $HOME/.bash
	ln -s -f $HERE/bash_completion /etc/bash_completion
fi

if [ "$VIM" != "n" ]; then
	log "info" "Moving vim configs to tmp/backup\n"
	mv -f $HOME/.vim $HOME/.vimrc $BKP_PATH
	if [ -e "$(which vim)" ]; then
		log "info" "Vim already installed\n"
	else
		if [ "$OSX" != "" ]; then
			log "info" "Install vim...\n"
			brew install macvim --env-std --with-override-system-vim --with-cscope --with-lua > /dev/null 2>&1
		else
			log "error" "Can't auto install vim\n"
		fi
	fi
	log "info" "Seting new configs to vim\n"
	ln -s -f $HERE/dotvim $HOME/.vim
	ln -s -f $HERE/vimrc $HOME/.vimrc
fi

if [ "$TMUX" != "n" ]; then
	if [ -e "$(which tmux)" ]; then
		log "info" "TMUX already installed\n"
	else
		if [ "$OSX" != "" ]; then
			log "info" "Install tmux...\n"
			brew install tmux > /dev/null 2>&1
		else
			log "error" "Can't auto install tmux\n"
		fi
	fi
	log "info" "Moving tmux configs to tmp/backup\n"
	mv -f $HOME/.tmux.conf $BKP_PATH
	log "info" "Seting new configs to tmux\n"
	if [ "$TMUX_SIMPLE" != "n" ]; then
		ln -s -f $HERE/tmux.simple.conf $HOME/.tmux.conf
	else
		ln -s -f $HERE/tmux.conf $HOME/.tmux.conf
	fi
fi

#log "info" "Moving others configs to tmp/backup\n"
#mv -f $HOME/.ssh/config $HOME/.eslintrc $BKP_PATH
#log "info" "Seting others new configs\n"
#ln -s -f $HERE/sshconfig $HOME/.ssh/config
#ln -s -f $HERE/eslintrc $HOME/.eslintrc

log "success" "Defined all configs\n"

if [ "$ZSH_VERSION" == "" ]; then
	log "info" "Installing zsh\n"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ "$ZSH" == "n" ]; then
	source $HOME/.bash_profile
fi

log "success" "Finished \o/"
