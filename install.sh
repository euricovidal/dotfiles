#!/bin/bash
HERE=`pwd`
BKP_PATH=$HERE/tmp/backup
GREEN="\e[1;32m"
NO_COLOR="\e[0m"

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

log "Use tmux [Y/n]: "
read TMUX

if [ "$GIT_EMAIL" == "" ] && [ "$RUBY" == "n" ] && [ "$ZSH" == "n" ] && [ "$TMUX" == "n" ]; then
	log "error" "Do nothing, bye..."
	exit
fi

echo "\n"
log "info" "CONFIRM:"
echo "\n"

[ "$GIT_EMAIL" != "" ] && log "info" "\t- Set GitHub (email: $GIT_EMAIL)\n"
[ "$RUBY" != "n" ] && log "info" "\t- Set Ruby configs\n"
[ "$ZSH" != "n" ] && log "info" "\t- Install ZSH and set configs\n"
[ "$TMUX" != "n" ] && log "info" "\t- Install TMUX and set configs\n"

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
	ln -sf $HERE/gitconfig $HOME/.gitconfig
	ln -sf $HERE/gitignore $HOME/.gitignore
fi

if [ "$RUBY" != "n" ]; then
	log "info" "Moving ruby configs to tmp/backup\n"
	mv -f $HOME/.irbrc $HOME/.gemrc $HOME/.rspec  $BKP_PATH
	log "info" "Seting new configs to ruby\n"
	ln -sf $HERE/inputrc $HOME/.inputrc
	ln -sf $HERE/gemrc $HOME/.gemrc
	ln -sf $HERE/rspec $HOME/.rspec
	ln -sf $HERE/irbrc $HOME/.irbrc
fi

if [ "$ZSH" != "n" ]; then
	log "info" "Moving zsh configs to tmp/backup\n"
	mv -f $HOME/.zshrc $BKP_PATH
	if [ "$ZSH_VERSION" == "" ]; then
		log "info" "Install zsh\n"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	fi
	mkdir -p ${ZSH_CUSTOM}/plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
	git clone https://github.com/caarlos0/zsh-open-pr.git ${ZSH_CUSTOM}/plugins/zsh-open-pr
	git clone git://github.com/zsh-users/zaw.git ${ZSH_CUSTOM}/plugins/zaw
	log "info" "Seting new configs to zsh\n"
	ln -sf $HERE/zshrc $HOME/.zshrc
else
	log "info" "Moving bash configs to tmp/backup\n"
	mv -f $HOME/.bash $HOME/.bash_history $BKP_PATH
	log "info" "Seting new configs to bash\n"
	ln -sf $HERE/bash_profile $HOME/.bash_profile
	ln -sf $HERE/bash_profile $HOME/.bashrc
	ln -sf $HERE/bash $HOME/.bash
	ln -sf $HERE/bash_completion /etc/bash_completion
fi

if [ "$TMUX" != "n" ]; then
	if [ -e "$(which tmux)" ]; then
		log "info" "TMUX already installed\n"
	else
		#if [ "$OSTYPE" =~ ^darwin ]; then
			log "info" "Install tmux...\n"
			brew install tmux &>2
		#else
	#		log "error" "Can't auto install tmux\n"
	#	fi
	fi
	log "info" "Moving tmux configs to tmp/backup\n"
	mv -f $HOME/.tmux.conf $BKP_PATH
	log "info" "Seting new configs to ruby\n"
	ln -sf $HERE/tmux.conf $HOME/.tmux.conf
fi

log "info" "Moving others configs to tmp/backup\n"
mv -f $HOME/.ssh/config $HOME/.vim $HOME/.vimrc $HOME/.eslintrc $BKP_PATH
log "info" "Seting others new configs\n"
ln -sf $HERE/sshconfig $HOME/.ssh/config
ln -s $HERE/dotvim $HOME/.vim
ln -sf $HERE/vimrc $HOME/.vimrc
ln -sf $HERE/eslintrc $HOME/.eslintrc

log "success" "Defined all configs\n"

if [ "$ZSH" == "n" ]; then
	source $HOME/.bash_profile
#else
	#source $HOME/.zshrc
fi
