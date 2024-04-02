#!/usr/bin/env bash
# Script to install JetBrains Nerd Font

FONT_DIR=~/.local/share/fonts

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
mkdir -p "${FONT_DIR}"
mv JetBrainsMono.tar.xz "${FONT_DIR}"
mkdir -p "${FONT_DIR}/JetBrainsMono"
tar -xf "${FONT_DIR}/JetBrainsMono.tar.xz" --directory "${FONT_DIR}/JetBrainsMono"
rm "${FONT_DIR}/JetBrainsMono.tar.xz"
