export NINJA_STATUS="[%p]: "
export DATE=$(date '+%Y-%m-%d')

alias ls="eza -h --icons --group-directories-first -1"
# alias bye="exit"
alias la="ls -ah"
alias ll="ls -alh"
alias weather="curl wttr.in"
alias watch_disas="watch -n 1 -c -t -x /usr/bin/gdb-multiarch -q -ex \"disas main\" -ex \"quit\""
alias ip="ip -c"
alias bat="bat --theme base16-256"
alias trans="trans --engine google"
alias qemu-aarch64="qemu-aarch64 -L /usr/aarch64-linux-gnu -E LD_LIBRARY_PATH=/usr/aarch64-linux-gnu/lib64:/usr/aarch64-linux-gnu/lib"
alias imgcat="kitty +kitten icat"
alias tree="exa --tree --icons"

export EDITOR=/usr/bin/vim

function disas
	if test (count $argv) -eq 1
		/usr/bin/gdb -q -ex "disas main" -ex "quit" $argv[1]
	else
		/usr/bin/gdb -q -ex "disas $argv[2]" -ex "quit" $argv[1]
    end
end
