if status is-interactive
    set fish_greeting
    set -U EDITOR nvim
    bind \cf 'tmux-sessionizer.sh'
    source ~/.aliases
end
