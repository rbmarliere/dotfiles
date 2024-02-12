#!/bin/bash

set -euo pipefail

DEPS=(
	# .
	stow

	# bash
	bash-completion
	fzf

	# mail
	isync
	lynx
	msmtp
	neomutt
	source-highlight
	urlscan
	# diff-so-fancy
	# oauth2.py
	# libsasl2-modules-kdexoauth2

	# news
	newsboat

	# neovim
	# neovim
	codespell
	ripgrep

	# sway
	acpi
	bemenu
	cliphist
	desktop-base
	dolphin
	grim
	j4-dmenu-desktop
	light
	mako-notifier
	pavucontrol
	pinentry-qt
	slurp
	sway
	swayidle
	swaylock
	waybar
	wf-recorder
	wireplumber
	wlrctl
	xdg-desktop-portal-gtk
	xdg-desktop-portal-kde
	xdg-desktop-portal-wlr

	# tmux
	tmux
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

fc-cache
