#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib.sh
. "$SCRIPT_DIR/lib.sh"

require_non_root "Run this script as your regular user, not root."

FLATPAK_LIST="$SCRIPT_DIR/flatpaks.txt"

if [ ! -f "$FLATPAK_LIST" ]; then
  die "Flatpak list not found: $FLATPAK_LIST"
fi

if ! command -v flatpak >/dev/null 2>&1; then
  die "flatpak command not found. Install flatpak first (for Fedora, use scripts/01-install-tools.sh)."
fi

if ! has_list_entries "$FLATPAK_LIST"; then
  echo "No Flatpak app IDs found in $FLATPAK_LIST"
  exit 0
fi

if ! flatpak remote-list --columns=name | grep -qx "flathub"; then
  echo "Adding flathub remote"
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

installed_count=0

while IFS= read -r line || [ -n "$line" ]; do
  case "$line" in
    ''|'#'*)
      continue
      ;;
    *)
      app_id="$(first_word "$line")"
      if [ -z "$app_id" ]; then
        continue
      fi

      echo "- Installing $app_id"
      flatpak install --user -y flathub "$app_id"
      installed_count=$((installed_count + 1))
      ;;
  esac
done < "$FLATPAK_LIST"

echo "Flatpak apps installed successfully ($installed_count apps)."