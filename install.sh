#!/usr/env bash

# Always run the install script inside the dotfiles repo
dotfiles=$(pwd)

# Bash
ln -sv $dotfiles/bash/bashrc ~/.bashrc
ln -sv $dotfiles/bash/bash_profile ~/.bash_profile

# Global aliases
ln -sv $dotfiles/aliases/aliases ~/.aliases

# Vim
ln -s $dotfiles/vim/ ~/.vim

# Zsh
ln -sv $dotfiles/zsh/zshrc ~/.zshrc
ln -sv $dotfiles/zsh/zprofile ~/.zprofile
mkdir -p ~/.zsh/
color_config_file="catppuccin_mocha-zsh-syntax-highlighting.zsh"
ln -sv $dotfiles/zsh/$color_config_file ~/.zsh/$color_config_file
