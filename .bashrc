if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export PATH=/home/$USER/.local/bin:/home/$USER/bin:$PATH
export VISUAL=vim
export EDITOR=vim

alias ..="cd .."
alias cdg="cd ~/git"
alias g="git"
alias la="ls -la"
alias shut="sudo shutdown -h now"
alias vi="vim"
