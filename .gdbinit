# add-auto-load-safe-path ~/src/

# opensuse workaround
set debuginfod enabled off

# enable TUI
layout src

# move focus to cmd pane to enable arrow keys navigation
focus cmd

set print pretty on

# enable logging so output from TUI is still visible
set logging file ~/.gdb.log
set trace-commands on
set logging on

alias re = target remote :1234
alias rr = tui refresh

python
import os

class Less(gdb.Command):
    def __init__(self):
        super().__init__("less", gdb.COMMAND_USER, gdb.COMPLETE_COMMAND)

    def invoke(self, argstr, from_tty):
        e = ["/usr/share/source-highlight/src-hilite-lesspipe.sh", "/usr/bin/src-hilite-lesspipe.sh"]
        for exec in e:
            if os.path.isfile(exec):
                with os.popen(exec, "w") as pipe:
                    try:
                        pipe.write(gdb.execute(argstr, to_string=True))
                    except Exception as e:
                        pipe.write(str(e))

Less()
end
