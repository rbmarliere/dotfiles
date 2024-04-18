BASE  = stow \
	bash-completion \
	fzf \
	tmux \
	vim

# mail
DEPS += isync \
	lynx \
	msmtp \
	neomutt \
	source-highlight \
	urlscan
	# oauth2.py
	# libsasl2-modules-kdexoauth2

# news
DEPS += newsboat

# neovim
DEPS += codespell \
	ripgrep \
	fd-find \
	neovim

# sway
DEPS += acpi \
	bemenu \
	breeze \
	breeze-gtk-theme \
	cliphist \
	desktop-base \
	dmenu \
	dolphin \
	grim \
	i3ipc-python \
	j4-dmenu-desktop \
	kio-extras \
	light \
	mako-notifier \
	ntp \
	pavucontrol \
	pinentry-qt \
	slurp \
	sway \
	swayidle \
	swaylock \
	waybar \
	wf-recorder \
	wireplumber \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-kde \
	xdg-desktop-portal-wlr

.PHONY: all deps clean

all:
	mkdir -p ~/.cache/vim/bkp
	mkdir -p ~/.cache/vim/swp
	mkdir -p ~/.cache/vim/und
	sudo apt install $(BASE)
	stow --verbose --restow --target=$$HOME .
	# *************** ADJUST '@continuum-save-interval' IN tmux.conf !

deps:
	mkdir -p ~/.cache/neomutt
	sudo apt install $(DEPS)

	# flatpak
	mkdir -p ~/.icons/default
	cp /usr/share/icons/default/index.theme ~/.icons/default

	fc-cache

clean:
	stow --verbose --delete --target=$$HOME .
	fc-cache
