#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

PACKAGE_LIST="$SCRIPT_DIR/data/packages-fedora.txt"

require_fedora

if [ ! -f "$PACKAGE_LIST" ]; then
  die "Package list not found: $PACKAGE_LIST"
fi

log_info "Installing packages from $PACKAGE_LIST"

# shellcheck disable=SC2046
set -- $(list_to_args "$PACKAGE_LIST")

if [ "$#" -eq 0 ]; then
  log_ok "No packages found in $PACKAGE_LIST"
  exit 0
fi

as_root dnf install -y "$@"

log_ok "Tools installed"