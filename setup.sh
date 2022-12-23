#!/bin/bash

git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

rm -r ~/.config/{i3,nvim}
rm ~/{.bashrc,.gitconfig,.inputrc,.tmux.conf}

ln -s "$(pwd)/nvim" ~/.config/nvim
ln -s "$(pwd)/i3" ~/.config/i3
ln -s "$(pwd)/.bashrc" ~/.bashrc
ln -s "$(pwd)/.gitconfig" ~/.gitconfig
ln -s "$(pwd)/.inputrc" ~/.inputrc
ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
