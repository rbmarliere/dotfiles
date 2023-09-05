set TTY1 (tty)
if [ "$TTY1" = "/dev/tty1" ]
    ch_remove_all_sessions
    exec sway
end
