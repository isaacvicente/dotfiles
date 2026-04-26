#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib.sh
. "$SCRIPT_DIR/lib.sh"

require_fedora

DNF_CONF="/etc/dnf/dnf.conf"

set_dnf_option() {
  key="$1"
  value="$2"

  if grep -Eq "^[[:space:]]*${key}=" "$DNF_CONF"; then
    as_root sed -i "s|^[[:space:]]*${key}=.*|${key}=${value}|" "$DNF_CONF"
  else
    printf '\n%s=%s\n' "$key" "$value" | as_root tee -a "$DNF_CONF" >/dev/null
  fi
}

set_dnf_option "defaultyes" "True"
set_dnf_option "max_parallel_downloads" "10"

fedora_version="$(rpm -E %fedora)"

if ! dnf repolist --all | grep -Eq '^rpmfusion-free[[:space:]]'; then
  as_root dnf install -y "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${fedora_version}.noarch.rpm"
fi

if ! dnf repolist --all | grep -Eq '^rpmfusion-nonfree[[:space:]]'; then
  as_root dnf install -y "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fedora_version}.noarch.rpm"
fi

as_root dnf group install -y multimedia

echo "dnf configured and RPM Fusion repos installed."