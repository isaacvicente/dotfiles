# [dotfiles](https://dotfiles.github.io)

Minimal config for a Fedora machine.

## Bootstrap

Run as your regular user (not root):

```sh
git clone https://github.com/isaacvicente/dotfiles.git
cd dotfiles
sh scripts/bootstrap.sh
```

`bootstrap.sh` runs all numbered scripts in `scripts/` in order.

Non-DNF tools (for example `starship`) are installed by the brew step using:

`scripts/data/packages-brew.txt`

## Optional validation

Run the full bootstrap flow in a clean container:

```sh
sh scripts/dev/validate-in-container.sh
```
