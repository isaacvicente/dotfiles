#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

require_non_root "Run this script as your regular user, not root."

REPO_ROOT="$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)"
SRC_DIR="$REPO_ROOT/src"

require_cmd "stow" "GNU stow is required but not installed."

backup_bash_files() {
  for file_name in .bashrc .bash_profile; do
    source_path="$HOME/$file_name"
    backup_path="$HOME/$file_name.old"

    if [ -f "$source_path" ] && [ ! -L "$source_path" ]; then
      if [ -e "$backup_path" ]; then
        log_info "Skipping $file_name backup: $backup_path already exists"
      else
        mv "$source_path" "$backup_path"
        log_info "Backed up $file_name to $file_name.old"
      fi
    fi
  done
}

for pkg_path in "$SRC_DIR"/*; do
  [ -d "$pkg_path" ] || continue

  pkg="$(basename "$pkg_path")"

  if [ "$pkg" = "bash" ]; then
    backup_bash_files
  fi

  log_info "Stowing $pkg"
  stow -d "$SRC_DIR" -t "$HOME" "$pkg"
done

log_ok "Dotfiles stowed"