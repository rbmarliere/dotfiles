#!/bin/bash

set -euo pipefail

DEPS=(
	bash-completion
	fzf
	ripgrep
	source-highlight
	stow
	urlscan
)
echo "DEPS=(${DEPS[*]})"
read -p "Install dependencies with apt? [y|N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	if [ "$(id -u)" -ne 0 ]; then
		sudo=sudo
	fi
	$sudo apt install -y "${DEPS[@]}"
fi

mkdir -p ~/.cache/neomutt

packages=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%P\n')
stow -Rv $packages
