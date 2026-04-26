# dotfiles

This repo was created to keep track of my [dotfiles](https://dotfiles.github.io/).

## Setup scripts

Single command:

  sh scripts/bootstrap.sh

Or run scripts in order:

  sh scripts/00-dnf.sh
  sh scripts/01-install-tools.sh
  sh scripts/02-install-fonts.sh
  sh scripts/03-stow.sh
  sh scripts/04-install-flatpaks.sh

To change the packages installed by `01-install-tools.sh`, edit:

  scripts/packages-fedora.txt

To change Flatpak app IDs installed by `04-install-flatpaks.sh`, edit:

  scripts/flatpaks.txt

## Validate on fresh container

Build a fresh Fedora container and run the full bootstrap flow inside it:

  sh scripts/validate-in-container.sh

This validation also runs `shellcheck` against all setup scripts.

The validator auto-detects container engine in this order: `podman`, then `docker`.

Optional environment variables:

  CONTAINER_ENGINE=podman sh scripts/validate-in-container.sh
  IMAGE_NAME=my-dotfiles-test sh scripts/validate-in-container.sh

## Install config files with `stow`

  stow -d src -t "$HOME" nvim

> See also: `--adopt` option in `man 8 stow`
