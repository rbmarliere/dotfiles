if status is-interactive
    set fish_greeting
    set PATH ~/.local/bin ~/bin $PATH
    test -f ~/.bash_aliases && source ~/.bash_aliases

    set fish_vi_force_cursor 1
    set fish_cursor_default block blink
    set fish_cursor_insert underscore blink
    set fish_cursor_replace_one beam blink
    set fish_cursor_visual block
end
