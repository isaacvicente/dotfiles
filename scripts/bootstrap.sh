#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

require_non_root "Do not run bootstrap as root. Run it as your target user."

find "$SCRIPT_DIR" -maxdepth 1 -type f -name '[0-9][0-9]-*.sh' | sort |
while IFS= read -r script_path; do
  step="$(basename "$script_path")"
  log_info "Running $step"
  sh "$script_path"
done

log_ok "Bootstrap completed"