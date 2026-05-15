#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

require_non_root "Run this script as your regular user, not root."

FLATPAK_LIST="$SCRIPT_DIR/data/flatpaks.txt"

if [ ! -f "$FLATPAK_LIST" ]; then
  die "Flatpak list not found: $FLATPAK_LIST"
fi

require_cmd "flatpak" "flatpak command not found. Install flatpak first (for Fedora, use scripts/01-install-tools.sh)."

if ! has_list_entries "$FLATPAK_LIST"; then
  log_ok "No Flatpak app IDs found in $FLATPAK_LIST"
  exit 0
fi

if ! flatpak remote-list --columns=name | grep -qx "flathub"; then
  log_info "Adding flathub remote"
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# shellcheck disable=SC2046
set -- $(list_to_args "$FLATPAK_LIST")

flatpak install flathub "$@" -y

log_ok "Flatpaks installed"