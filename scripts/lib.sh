#!/bin/sh

die() {
  echo "$1" >&2
  exit 1
}

is_root() {
  [ "$(id -u)" -eq 0 ]
}

require_non_root() {
  message="$1"
  if is_root; then
    die "$message"
  fi
}

is_fedora() {
  [ -f /etc/os-release ] || return 1
  # shellcheck disable=SC1091
  . /etc/os-release
  [ "${ID:-}" = "fedora" ]
}

require_fedora() {
  if ! is_fedora; then
    die "This script is Fedora-specific and must run on Fedora."
  fi
}

as_root() {
  if is_root; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    die "This step requires root privileges and sudo was not found."
  fi
}

first_word() {
  printf '%s' "$1" | awk '{print $1}'
}

has_list_entries() {
  list_file="$1"

  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      ''|'#'*)
        continue
        ;;
      *)
        return 0
        ;;
    esac
  done < "$list_file"

  return 1
}

detect_container_engine() {
  if [ -n "${CONTAINER_ENGINE:-}" ]; then
    printf '%s\n' "$CONTAINER_ENGINE"
    return 0
  fi

  if command -v podman >/dev/null 2>&1; then
    printf '%s\n' "podman"
    return 0
  fi

  if command -v docker >/dev/null 2>&1; then
    printf '%s\n' "docker"
    return 0
  fi

  return 1
}