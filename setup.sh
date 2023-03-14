#!/bin/bash

mkdir -p "$HOME/.config"

packer="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$packer" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$packer"
fi

files=(
    .bashrc
    .config/alacritty
    .config/i3
    .config/nvim
    .gitconfig
    .inputrc
    .tmux.conf
)

for file in "${files[@]}"; do
    ln -s -f -T "$(pwd)/$file" "$HOME/$file"
done
