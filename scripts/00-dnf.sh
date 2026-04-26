#!/bin/sh

set -eu

SCRIPT_DIR="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
# shellcheck source=scripts/lib/common.sh
. "$SCRIPT_DIR/lib/common.sh"

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

install_rpmfusion_repo() {
  repo_name="$1"
  repo_kind="$2"

  if ! dnf repolist --all | grep -Eq "^${repo_name}[[:space:]]"; then
    as_root dnf install -y "https://download1.rpmfusion.org/${repo_kind}/fedora/${repo_name}-release-${fedora_version}.noarch.rpm"
  fi
}

install_rpmfusion_repo "rpmfusion-free" "free"
install_rpmfusion_repo "rpmfusion-nonfree" "nonfree"

as_root dnf group install -y multimedia

log_ok "DNF configured and RPM Fusion repos installed"