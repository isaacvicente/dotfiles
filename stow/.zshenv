# XDG Base Directory support
export ZDOTDIR="$HOME/.config/zsh"

# Run Firefox with Wayland instead of XWayland
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# If using Zsh, export SHELL variable
export SHELL=/bin/zsh
