if status is-interactive
    set fish_cursor_default block
    set fish_cursor_insert underscore
    set fish_cursor_replace_one line
    set fish_cursor_visual block
    set fish_greeting
    set PATH ~/.local/bin ~/bin $PATH
    set -U EDITOR nvim
    source ~/.aliases
end
