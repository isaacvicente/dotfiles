# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/zak/.config/zsh/.zshrc'

export KEYTIMEOUT=1

# Fix the most annoying thing about vi-mode in zsh
# (can't backspace within insert mode)
bindkey "^?" backward-delete-char

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi

# Extend PATH so that it's possible to run user binaries
export PATH=~/.local/share/cargo/bin:~/.local/bin:$PATH

# Set Vim as the Git local text editor
export GIT_EDITOR=vim

# Make ESC a little faster in Zsh
# (https://www.johnhawthorn.com/2012/09/vi-escape-delays/)
export KEYTIMEOUT=1

# I want a colorful `ls`
eval "$(dircolors)"

# Initialization of zoxide
if command -v zoxide &> /dev/null
then
    eval "$(zoxide init zsh)"
fi

# glow completion for zsh
if command -v glow &> /dev/null
then
    eval "$(glow completion zsh)"
fi

# Set the Cattpuccin theme for fzf
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

source ~/.config/fzf/config

source "$ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme"

function nvims() {
  items=("main" "kickstart")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "main" ]]; then
    config="nvim"
  fi
  export NVIM_APPNAME="${config}"
  nvim $@
}

bindkey -s ^n "nvims\n"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

fpath=("$ZDOTDIR/zsh-completions/src" $fpath)
source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2> /dev/null # Must be at end


[ -f $XDG_CONFIG_HOME/fzf/key-bindings.zsh ] && source $XDG_CONFIG_HOME/fzf/key-bindings.zsh
[ -f $XDG_CONFIG_HOME/fzf/completion.zsh ] && source $XDG_CONFIG_HOME/fzf/completion.zsh
