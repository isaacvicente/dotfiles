#!/usr/bin/env bash
font_dir=~/.local/share/fonts

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir -p "${font_dir}"
mv JetBrainsMono.tar.xz "${font_dir}"
mkdir -p "${font_dir}/JetBrainsMono"
tar -xf "${font_dir}/JetBrainsMono.tar.xz" --directory "${font_dir}/JetBrainsMono"
rm "${font_dir}/JetBrainsMono.tar.xz"
