BASE_DEPS = \
	bash-completion \
	fzf \
	libnotify-bin \
	psmisc \
	stow \
	tmux \
	vim \
	wget

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
	seahorse \
	slurp \
	sway \
	swayidle \
	swaylock \
	udisks2 \
	viewnior \
	vlc \
	waybar \
	wf-recorder \
	wireplumber \
	wl-clipboard \
	wtype \
	xdg-desktop-portal-wlr

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

MAIL_DEPS = \
	isync \
	lynx \
	msmtp \
	neomutt \
	pandoc \
	urlscan \
	uuid-runtime
	# libsasl2-modules-kdexoauth2 \

.PHONY: all dev desktop clean

all:
	mkdir -p $(DIR)
	sudo apt install $(BASE)
	sudo update-alternatives --config editor
	stow --verbose --restow --target=$$HOME .

dev:
	sudo apt install $(DEV_DEPS)
	sudo update-alternatives --config editor

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file ~/.config/tmux/tmux.conf
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

	ln -sf $$HOME/.config/tmux/tmux.service $$HOME/.config/systemd/user/tmux.service
	ln -sf $$HOME/.config/sway/dev $$HOME/.config/sway/autostart
	sudo systemctl enable systemd-networkd-wait-online.service

desktop:
	sudo apt install $(DESKTOP_DEPS)
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
	sudo apt install $(MAIL_DEPS)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O ~/.local/bin/oauth2.py

clean:
	stow --verbose --delete --target=$$HOME .
	sudo systemctl disable systemd-networkd-wait-online.service
