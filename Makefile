BASE_DEPS = \
	stow \
	bash-completion \
	fzf \
	psmisc \
	tmux \
	vim

DEV_DEPS = \
	fd-find \
	golang-go \
	locate \
	neovim \
	npm \
	python3-pip \
	python3-venv \
	ripgrep \
	rustup

DESKTOP_DEPS = \
	ark \
	bemenu \
	breeze-icon-theme \
	copyq \
	desktop-base \
	dolphin \
	gnome-keyring \
	grim \
	jq \
	kio-extras \
	libnotify-bin \
	light \
	mako-notifier \
	ntp \
	pavucontrol \
	python3-i3ipc \
	slurp \
	sway \
	swayidle \
	swaylock \
	udisks2 \
	vlc \
	waybar \
	wf-recorder \
	wireplumber \
	wl-clipboard \
	wtype \
	xdg-desktop-portal-wlr

DIR = \
	$$HOME/.cache/neomutt/ \
	$$HOME/.cache/nvim/bkp \
	$$HOME/.cache/nvim/swp \
	$$HOME/.cache/nvim/und \
	$$HOME/.cache/vim/bkp \
	$$HOME/.cache/vim/swp \
	$$HOME/.cache/vim/und \
	$$HOME/.config/systemd/user \
	$$HOME/.local/bin

.PHONY: all dev desktop clean

all:
	mkdir -p $(DIR)
	sudo apt install $(BASE)
	stow --verbose --restow --target=$$HOME .

dev:
	sudo apt install $(DEV_DEPS)
	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

desktop:
	sudo apt install $(DESKTOP_DEPS)
	fc-cache
	systemctl --user enable tmux
	sudo systemctl enable systemd-networkd-wait-online.service
	ln -sf $$HOME/.config/sway/desktop $$HOME/.config/sway/autostart
	git update-index --assume-unchanged .bash_profile
	@for patch in .patches/*; do \
		target=$$(grep -m 1 '^+++ ' "$$patch" | cut -d ' ' -f 2 | cut -f1); \
		if [ -f "$$target" ]; then \
			echo patching $$target; \
			sudo patch -s -N -r - $$target < $$patch; \
		fi \
	done

clean:
	stow --verbose --delete --target=$$HOME .
