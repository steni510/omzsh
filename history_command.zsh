function history_command {
	local command=""
	if [[ ( $# != 1 ) ]]; then
		echo "usage: $0 (number from history)"
		return 1
	fi
	command=$(history | sed -n $1p | sed 's/.\{7\}//')
	echo "ececuting command: $command"
	eval $command
}

alias hcmd='history_command'