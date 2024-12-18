set history save on
set history filename ~/.gdb.hist
set history size 4096
set debuginfod enabled off
set print pretty on
set logging file ~/.gdb.log
set trace-commands on
set logging on
set follow-fork-mode child

alias follow-child = set follow-fork-mode child
alias follow-parent = set follow-fork-mode parent
alias re = target remote :1234
alias rr = tui refresh

# add-auto-load-safe-path ~/src/

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

