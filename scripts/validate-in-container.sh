#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib.sh
. "$SCRIPT_DIR/lib.sh"

REPO_ROOT="$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)"

CONTAINER_ENGINE="$(detect_container_engine || true)"
IMAGE_NAME="${IMAGE_NAME:-dotfiles-bootstrap-test}"
CONTAINERFILE="${CONTAINERFILE:-$REPO_ROOT/Containerfile.test}"

if [ -z "$CONTAINER_ENGINE" ]; then
  die "No container engine found. Install podman or docker."
fi

if ! command -v "$CONTAINER_ENGINE" >/dev/null 2>&1; then
  die "Container engine not found in PATH: $CONTAINER_ENGINE"
fi

if [ ! -f "$CONTAINERFILE" ]; then
  die "Containerfile not found: $CONTAINERFILE"
fi

volume_suffix=""
if [ "$CONTAINER_ENGINE" = "podman" ]; then
  volume_suffix=":Z"
fi

echo "Building image: $IMAGE_NAME"
"$CONTAINER_ENGINE" build -f "$CONTAINERFILE" -t "$IMAGE_NAME" "$REPO_ROOT"

echo "Running bootstrap in clean container"
"$CONTAINER_ENGINE" run --rm \
  -v "$REPO_ROOT:/work/dotfiles${volume_suffix}" \
  "$IMAGE_NAME" \
  sh -s <<'CONTAINER_SCRIPT'
set -eu
cd /work/dotfiles

# Ensure bash backup behavior is exercised.
[ -f "$HOME/.bashrc" ] || printf "# container bashrc\n" > "$HOME/.bashrc"
[ -f "$HOME/.bash_profile" ] || printf "# container bash_profile\n" > "$HOME/.bash_profile"

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck scripts/*.sh
fi

sh scripts/bootstrap.sh

[ -f "$HOME/.bashrc.old" ]
[ -f "$HOME/.bash_profile.old" ]
[ -d "$HOME/.local/share/fonts/JetBrainsMonoNerd" ]
[ -L "$HOME/.config/nvim" ]

if ! find "$HOME/.local/share/fonts/JetBrainsMonoNerd" -type f \( -name "*.ttf" -o -name "*.otf" \) | grep -q .; then
  echo "Installed font files were not found" >&2
  exit 1
fi

echo "Container validation passed"
CONTAINER_SCRIPT

echo "Done"