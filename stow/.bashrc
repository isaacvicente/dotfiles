###############
## ~/.bashrc ##
###############

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

# XDG Base Directory global variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

mkdir -p "$XDG_STATE_HOME"/bash
export HISTFILE="$XDG_STATE_HOME"/bash/history

export PATH=~/.local/bin:$PATH

# I want a colorful `ls`
if command -v dircolors &>/dev/null; then
  eval "$(dircolors)"
fi

# Initialization of zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# glow completion for bash
if command -v glow &>/dev/null; then
  eval "$(glow completion bash)"
fi

## Bash functions (https://wiki.archlinux.org/title/Bash/Functions)
# cd and ls in one
cl() {
  local dir="$1"
  local dir="${dir:=$HOME}"
  if [[ -d "$dir" ]]; then
    cd "$dir" >/dev/null
    ls --color=auto
  else
    echo "bash: cl: $dir: Directory not found"
  fi
}

## Source the ~/.aliases file
if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi

# ~~~~~~~~~~ Bash prompt ~~~~~~~~~~

# PS1='[\u@\h \W]\$ '

# from: https://gitweb.gentoo.org/repo/gentoo.git/tree/app-shells/bash/files/bashrc

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# Unlimited history list
# https://stackoverflow.com/a/12234989
export HISTSIZE=-1
export HISTFILESIZE=-1

# Avoid duplicates in Bash `history`..
export HISTCONTROL=ignoredups:erasedups

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# from: https://github.com/mischavandenburg/dotfiles/blob/main/.bashrc

if [[ -f "$XDG_CONFIG_HOME/git/git-prompt.sh" ]]; then
  source "$XDG_CONFIG_HOME/git/git-prompt.sh"
fi

if [[ -f "$XDG_CONFIG_HOME/git/git-completion.bash" ]]; then
  source "$XDG_CONFIG_HOME/git/git-completion.bash"
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

# colorized prompt with git branch
export PS1='\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\w\[\e[0m\] $(__git_ps1 "(%s)")\n$ '

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if [[ -f ~/.work ]]; then
  source ~/.work
fi

[ -f $XDG_CONFIG_HOME/fzf/key-bindings.bash ] && source $XDG_CONFIG_HOME/fzf/key-bindings.bash
[ -f $XDG_CONFIG_HOME/fzf/completion.bash ] && source $XDG_CONFIG_HOME/fzf/completion.bash
# openstack auto completion for bash
# run: openstack complete --shell bash > ~/.openstack_completion.bash
[ -f ~/.openstack_completion.bash ] && source ~/.openstack_completion.bash

if [[ -d ~/.fzf/bin ]]; then
  export PATH=~/.fzf/bin:$PATH
fi

[ -f "/home/zak/.ghcup/env" ] && source "/home/zak/.ghcup/env" # ghcup-env

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
