## dotfiles

This repo was created to keep track of my [dotfiles](https://dotfiles.github.io/).

### Install fonts
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"`

### Install config files with `stow`
`stow --target=$HOME  stow/`

> See also: `--adopt` option in `man 8 stow`
