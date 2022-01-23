if [[ $- != *i* ]] ; then
	return
fi

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export VISUAL=vim
export EDITOR=vim

alias ..="cd .."
alias cdg="cd ~/git"
alias g="git"
alias ls="ls --color=auto"
alias la="ls -la"
alias shut="sudo shutdown -h now"
alias vi="vim"
alias apt="sudo apt"

