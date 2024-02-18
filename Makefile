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
	ripgrep
	# neovim

# sway
DEPS += acpi \
	breeze \
	breeze-gtk-theme \
	bemenu \
	dmenu \
	cliphist \
	desktop-base \
	dolphin \
	grim \
	j4-dmenu-desktop \
	light \
	mako-notifier \
	pavucontrol \
	pinentry-qt \
	slurp \
	sway \
	swayidle \
	swaylock \
	waybar \
	wf-recorder \
	wireplumber \
	wlrctl \
	xdg-desktop-portal-gtk \
	xdg-desktop-portal-kde \
	xdg-desktop-portal-wlr

all:
	mkdir -p ~/.cache/vim/bkp
	mkdir -p ~/.cache/vim/swp
	mkdir -p ~/.cache/vim/und
	sudo apt install $(BASE)
	stow --verbose --restow --target=$$HOME */
	# *************** ADJUST '@continuum-save-interval' IN tmux.conf !
	fc-cache

deps:
	mkdir -p ~/.cache/neomutt
	sudo apt install $(DEPS)

clean:
	stow --verbose --delete --target=$$HOME */
	fc-cache
