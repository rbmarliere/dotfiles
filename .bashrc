export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export EDITOR="nvim"

PS1="\D{%H:%M} \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "
PS1="\[\e]0;\u@\h: \w\a\]$PS1"

shopt -s histappend

alias ..="cd .."
alias cdg="cd ~/git"
alias g="git"
alias grep="grep --color=auto"
alias la="ls --color=auto -la"
alias ls="ls --color=auto"
alias reboot="sudo reboot"
alias shut="sudo shutdown -h now"
alias vi="nvim"
alias apt="sudo apt"
alias systemctl="sudo systemctl"
alias dd="sudo dd status=progress"
alias dpkg="sudo dpkg"
alias dmesg="sudo dmesg"
alias mount="sudo mount"
alias umount="sudo umount"

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
