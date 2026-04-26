#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

require_non_root "Run this script as your regular user, not root."

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
FONT_DIR="${HOME}/.local/share/fonts/JetBrainsMonoNerd"

tmp_dir="$(mktemp -d)"
archive_path="$tmp_dir/JetBrainsMono.tar.xz"

cleanup() {
  rm -rf "$tmp_dir"
}

trap cleanup EXIT INT TERM

mkdir -p "$FONT_DIR"

if command_exists curl; then
  curl -fL "$FONT_URL" -o "$archive_path"
elif command_exists wget; then
  wget -O "$archive_path" "$FONT_URL"
else
  echo "Need curl or wget to download fonts." >&2
  exit 1
fi

tar -xf "$archive_path" -C "$FONT_DIR"

if command_exists fc-cache; then
  fc-cache -f "$HOME/.local/share/fonts"
fi

log_ok "JetBrainsMono Nerd Font installed in $FONT_DIR"