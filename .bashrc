export EDITOR="$HOME/.local/bin/vi"
export HISTFILE="$HOME/.bash_eternal_history"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
export LESS="-R --mouse"
export PATH="$HOME/.local/bin:$PATH"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend

function parse_git_dirty {
	[[ $(git status --porcelain 2> /dev/null) ]] && echo " *"
}
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \1$(parse_git_dirty)/"
}
export PS1='\[\e[00;36m\]\t \[\e[00;91m\]${debian_chroot:+$debian_chroot }\[\e[00m\]\u@\h \[\e[00;32m\]\w\[\e[00;33m\]$(parse_git_branch)\[\e[00m\]\n\$ '
export PS0='\[\e]0;$(history 1 | cut -d " " -f6-)\a\]'

alias ..="cd .."
alias g="git"
alias grep="grep --color=auto"
alias la="ls --color=auto -la"
alias ll="ls --color=auto -l"
alias ls="ls --color=auto"

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"
[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ] && export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
