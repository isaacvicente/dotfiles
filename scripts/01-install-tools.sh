#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib.sh
. "$SCRIPT_DIR/lib.sh"

PACKAGE_LIST="$SCRIPT_DIR/packages-fedora.txt"

require_fedora

if [ ! -f "$PACKAGE_LIST" ]; then
  die "Package list not found: $PACKAGE_LIST"
fi

echo "Installing packages from $PACKAGE_LIST"

installed_count=0

while IFS= read -r line || [ -n "$line" ]; do
  case "$line" in
    ''|'#'*)
      continue
      ;;
    *)
      pkg="$(first_word "$line")"
      if [ -z "$pkg" ]; then
        continue
      fi

      echo "- Installing $pkg"
      as_root dnf install -y "$pkg"
      installed_count=$((installed_count + 1))
      ;;
  esac
done < "$PACKAGE_LIST"

if [ "$installed_count" -eq 0 ]; then
  echo "No packages found in $PACKAGE_LIST"
  exit 0
fi

echo "Tools installed successfully ($installed_count packages)."