#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

BREW_PACKAGE_LIST="$SCRIPT_DIR/data/packages-brew.txt"
BREW_BIN=""

require_non_root "Run this script as your regular user, not root."

if [ ! -f "$BREW_PACKAGE_LIST" ]; then
  die "Brew package list not found: $BREW_PACKAGE_LIST"
fi

if [ ! -s "$BREW_PACKAGE_LIST" ] || ! has_list_entries "$BREW_PACKAGE_LIST"; then
  log_ok "No Brew packages found in $BREW_PACKAGE_LIST"
  exit 0
fi

if command_exists brew; then
  BREW_BIN="brew"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
else
  require_cmd "curl" "curl is required to install Homebrew"
  require_cmd "bash" "bash is required to install Homebrew"

  log_info "Installing Homebrew"
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if command_exists brew; then
    BREW_BIN="brew"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
  else
    die "Homebrew installation finished, but brew command was not found."
  fi
fi

log_info "Installing packages from $BREW_PACKAGE_LIST"
# shellcheck disable=SC2046
"$BREW_BIN" install $(list_to_args "$BREW_PACKAGE_LIST")

log_ok "Brew tools installed"
