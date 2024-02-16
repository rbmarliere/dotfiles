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
	sudo apt install $(BASE)
	stow -Rv -t $$HOME */
	fc-cache
	# *************** ADJUST '@continuum-save-interval' IN tmux.conf !

deps:
	mkdir -p ~/.cache/neomutt
	sudo apt install $(DEPS)

clean:
	stow -Dv -t $$HOME */
	fc-cache
