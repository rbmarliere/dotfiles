if [[ $- != *i* ]] ; then
	return
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export VISUAL=vim
export EDITOR=vim

alias ..="cd .."
alias apt="sudo apt"
alias cdg="cd ~/git"
alias fdisk="sudo fdisk"
alias g="git"
alias la="ls -la"
alias ls="ls --color=auto"
alias mount="sudo mount"
alias py="python3"
alias reboot="sudo reboot"
alias shut="sudo shutdown -h now"
alias umount="sudo umount"
alias vi="vim"

