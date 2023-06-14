# source ~/.gef-283690ae9bfcecbb3deb80cd275d327c46b276b5.py
source /usr/share/pwndbg/gdbinit.py
set pagination off
set disassembly-flavor intel
set print asm-demangle on
set history remove-duplicates 10
set history filename ".gdb_history"
set history size unlimited

source /home/dan/splitmind/gdbinit.py
python
import splitmind
(splitmind.Mind()
 .tell_splitter(show_titles=True)
 .tell_splitter(set_title="Main")
 .right(display="backtrace", size="20%")
 .above(of="main", display="disasm", size="80%", banner="none")
 .right(cmd='tty; tail -f /dev/null', size="50%", clearing=False)
 .tell_splitter(set_title='Input / Output')
 .above(display="stack", size="80%")
 .above(display="legend", size="25")
 .show("regs", on="legend")
 .below(of="backtrace", cmd="ipython", size="30%")
 .above(of="disasm", display="code", banner="none")
).build(nobanner=True)
end
set context-code-lines 10
set context-source-code-lines 30
set context-sections regs args disasm stack backtrace code
set resolve-heap-via-heuristic on
set debuginfod enabled on
