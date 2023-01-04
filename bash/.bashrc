###############
## ~/.bashrc ##
###############

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Bash functions (https://wiki.archlinux.org/title/Bash/Functions)
# cd and ls in one
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls --color=auto
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}

## Source the ~/.aliases file
source ~/.aliases

## Bash prompt
PS1='[\u@\h \W]\$ '
