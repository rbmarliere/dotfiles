#!/bin/bash

mkdir -p "$HOME/.config"

files=(
    .bashrc
    .config/**
    .inputrc
)

for file in "${files[@]}"; do
    ln -s -f -T "$(pwd)/$file" "$HOME/$file"
done
