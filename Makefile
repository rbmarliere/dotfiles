.PHONY: all dev desktop clean

DIR = \
	$$HOME/.cache/neomutt/ \
	$$HOME/.cache/neomutt/bodies \
	$$HOME/.cache/nvim/bkp \
	$$HOME/.cache/nvim/swp \
	$$HOME/.cache/nvim/und \
	$$HOME/.cache/vim/bkp \
	$$HOME/.cache/vim/swp \
	$$HOME/.cache/vim/und \
	$$HOME/.config/systemd/user \
	$$HOME/.local/bin

ifeq (, $(shell which systemctl 2>/dev/null))
  $(error "Systemd is required")
endif

ifneq (, $(shell which zypper 2>/dev/null))
  INSTALL_CMD := sudo zypper install -y
  DEPS_DIR := .deps/suse
else ifneq (, $(shell which apt 2>/dev/null))
  INSTALL_CMD := sudo apt install -y
  DEPS_DIR := .deps/debian
else
  $(error "Distribution not supported")
endif

all:
	mkdir -p $(DIR)
	@xargs $(INSTALL_CMD) < $(DEPS_DIR)/base
	sudo update-alternatives --config editor
	stow --verbose --restow --target=$$HOME .

dev:
	@xargs $(INSTALL_CMD) < $(DEPS_DIR)/dev
	sudo update-alternatives --config editor

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file ~/.config/tmux/tmux.conf
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

	ln -sf $$HOME/.config/tmux/tmux.service $$HOME/.config/systemd/user/tmux.service
	ln -sf $$HOME/.config/sway/dev $$HOME/.config/sway/autostart
	sudo systemctl enable systemd-networkd-wait-online.service

desktop:
	@xargs $(INSTALL_CMD) < $(DEPS_DIR)/desktop
	fc-cache
	@for patch in .patches/*; do \
		target=$$(grep -m 1 '^+++ ' "$$patch" | cut -d ' ' -f 2 | cut -f1); \
		if [ -f "$$target" ]; then \
			echo patching $$target; \
			sudo patch -s -N -r - $$target < $$patch; \
		fi \
	done
	git update-index --assume-unchanged .bash_profile

mail:
	@xargs $(INSTALL_CMD) < $(DEPS_DIR)/mail
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O ~/.local/bin/oauth2.py

clean:
	stow --verbose --delete --target=$$HOME .
	sudo systemctl disable systemd-networkd-wait-online.service
