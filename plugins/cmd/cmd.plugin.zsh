# Easily execute commands by manually adding labels of commands
# labels are sotroed in a file $LABELFILE (default $HOME/.labels)
#
# cmd FOO: execute command with label FOO
# label FOO 1234: create a label named FOO of history command 1234
# unlabel FOO: delete a label
# labels: lists all labels
#
#TODO: implement autocomplete
#
export LABELPATH=$HOME/.labels

cmd() {
	if [[ ! -f "$LABELPATH/$1" ]]; then
		echo "No such label: $1"
		return 1
	fi
	local command; read command < "$LABELPATH/$1"
	echo "ececuting command: $command"
	eval $command
}

label() {
	local command=""
	local file=""
	if [[ ( $# == 2 ) ]]; then
		command=$(_history_command $2)
	elif [[ ( $# == 1) ]]; then
		local num=$(history | wc -l)
		command=$(_history_command $num)
	else
		echo "Usage:"
		echo "Label command number: $1 label num"
		echo "Label last command:   $1 label"
		return 1
	fi
	mkdir -p $LABELPATH
	if [[ -f "$LABELPATH/$1" ]]; then
		echo "Label $1 already in use"
		return 1
	fi
	if read -q \?"Mark command \"$command\" as $1? (y/n) "; then
		touch "$LABELPATH/$1"
		echo $command >> "$LABELPATH/$1"
	fi
}

unlabel() {
	rm -i "$LABELPATH/$1"
}

labels() {
	local max=0
	for link in $LABELPATH/*; do
		if [[ ${#link:t} -gt $max ]]; then
			max=${#link:t}
		fi
	done
	local printf_label_template="$(printf -- "%%%us " "$max")"
	for label in $LABELPATH/*; do
		local line=""; read line < $label
		local labelname="$fg[cyan]${label:t}$reset_color"
		local command="$fg[gray]"$line"$reset_color"
		printf -- "$printf_label_template" "$labelname"
		printf -- "-> %s\n" "$command"
	done
}

function _history_command {
	local command=""
	command=$(history | sed -n $1p | sed 's/.\{7\}//')
	echo "$command"
}

#_completelabels() {
#	if [[ $(ls "${LABELPATH}" | wc -l) -gt 1 ]]; then
#		reply=($(ls $LABELPATH/**/*(-) | grep : | sed -E 's/(.*)\/([_a-zA-Z0-9\.\-]*):$/\2/g'))
#	else
#		if readlink -e "${MARKPATH}"/* &>/dev/null; then
#			reply=($(ls "${MARKPATH}"))
#		fi
#	fi
#}
#compctl -K _completelabels cmd
#compctl -K _completelabels unlabel
#
#_label_expansion() {
#	setopt extendedglob
#	autoload -U modify-current-argument
#	modify-current-argument '$(readlink "$LABELPATH/$ARG")'
#}
#zle -N _label_expansion
#bindkey "^g" _label_expansion
