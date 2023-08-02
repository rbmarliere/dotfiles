function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind -M insert \cf 'tmux-sessionizer.sh'
    bind -M default \cf 'tmux-sessionizer.sh'
    bind -M insert ! bind_bang
    bind -M insert '$' bind_dollar
end
