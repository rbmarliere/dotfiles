export EDITOR=vim
export PATH=$HOME/.local/bin:$HOME/bin:$PATH
export PS1='\D{%H:%M} \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '

shopt -s histappend

set -o vi

bind -s 'set completion-ignore-case on'

alias ..="cd .."
alias cdg="cd ~/git"
alias g="git"
alias grep="grep --color=auto"
alias la="ls --color=auto -la"
alias ls="ls --color=auto"
alias reboot="sudo reboot"
alias shut="sudo shutdown -h now"
alias vi="vim"

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

