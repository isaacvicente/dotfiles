#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

# shellcheck source=scripts/lib.sh
. "$SCRIPT_DIR/lib.sh"

require_non_root "Do not run bootstrap as root. Run it as your target user."

run_step() {
  step="$1"
  script_path="$SCRIPT_DIR/$step"

  if [ ! -f "$script_path" ]; then
    echo "Missing setup script: $script_path" >&2
    exit 1
  fi

  echo "==> Running $step"
  sh "$script_path"
}

for step in 00-dnf.sh 01-install-tools.sh 02-install-fonts.sh 03-stow.sh 04-install-flatpaks.sh; do
  run_step "$step"
done

echo "Bootstrap completed successfully."