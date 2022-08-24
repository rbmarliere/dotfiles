if [[ $- != *i* ]] ; then
	return
fi

PS1='\D{%H:%M} \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '

export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export VISUAL=vim
export EDITOR=vim

alias ..="cd .."
alias cdg="cd ~/git"
alias g="git"
alias la="ls --color=auto -la"
alias ls="ls --color=auto"
alias reboot="sudo reboot"
alias shut="sudo shutdown -h now"
alias vi="vim"

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

