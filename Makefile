DIR = \
	$$HOME/.cache/neomutt/ \
	$$HOME/.cache/nvim/bkp \
	$$HOME/.cache/nvim/swp \
	$$HOME/.cache/nvim/und \
	$$HOME/.cache/vim/bkp \
	$$HOME/.cache/vim/swp \
	$$HOME/.cache/vim/und \
	$$HOME/.local/bin \
	$$HOME/.local/share/applications

ifeq (, $(shell which systemctl 2>/dev/null))
  $(error "Systemd is required")
endif

ifneq (, $(shell which zypper 2>/dev/null))
  DISTRO := suse
  INSTALL_CMD := sudo zypper install
else ifneq (, $(shell which apt 2>/dev/null))
  DISTRO := debian
  INSTALL_CMD := sudo apt install
else
  $(error "Distribution not supported")
endif

DEPS_DIR := .deps/$(DISTRO)

.PHONY: all
all: base links

.PHONY: links
links:
	mkdir -p $(DIR)
	stow --verbose --restow --target=$$HOME .

.PHONY: base
base:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/base)

ifeq ($(DISTRO),suse)
	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 50
else ifeq ($(DISTRO),debian)
	sudo update-alternatives --config editor
endif

	sudo update-alternatives --config vi

.PHONY: dev
dev:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/dev)

	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 40
	sudo update-alternatives --config vi

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file ~/.config/tmux/tmux.conf
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

.PHONY: flatpak
flatpak:
	flatpak install flathub $$(tr "\n" " " < $(DEPS_DIR)/flatpak)

.PHONY: wm
wm: base flatpak
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/wm)
	fc-cache

	for patch in .patches/*; do \
		target=$$(grep -m 1 '^+++ ' "$$patch" | cut -d ' ' -f 2 | cut -f1); \
		if [ -f "$$target" ]; then \
			echo patching $$target; \
			sudo patch -s -N -r - $$target < $$patch || true; \
		fi \
	done
	git update-index --assume-unchanged .bash_profile

ifeq ($(DISTRO),suse)
	sudo ln -sf /usr/share/terminfo/f/foot-extra /usr/share/terminfo/f/foot

	# printer
	systemctl enable cups
	systemctl enable avahi-daemon
	# systemctl disable firewalld

	# zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/ openSUSE_Tumbleweed/ packman
	# zypper dup --from packman --allow-vendor-change
endif

.PHONY: autologin
autologin:
	sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
	echo "[Service]" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $$(whoami) %I \$$TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "Environment=XDG_SESSION_TYPE=wayland" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
ifeq ($(DISTRO),suse)
	# enable getty@tty1
	sudo ln -sf /usr/lib/systemd/system/multi-user.target /etc/systemd/system/default.target
endif

.PHONY: desktop
desktop: wm autologin
	echo "include config.d/$(DISTRO)/desktop" > $$HOME/.config/sway/autoload

ifeq ($(DISTRO),suse)
	sudo zypper remove --clean-deps nvidia*
	sudo echo "blacklist nvidia" > /etc/modprobe.d/60-blacklist.conf
	sudo echo "blacklist amdgpu" >> /etc/modprobe.d/60-blacklist.conf
	# sudo echo 'add_dracutmodules+=" bluetooth "' > /etc/dracut.conf.d/90-bluetooth.conf
	sudo dracut --force
	# sudo grub2-mkconfig -o /boot/grub2/grub.cfg
endif

.PHONY: laptop
laptop: wm autologin
	echo "include config.d/$(DISTRO)/laptop" > $$HOME/.config/sway/autoload

.PHONY: mail
mail:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/mail)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O ~/.local/bin/oauth2.py
	chmod +x ~/.local/bin/oauth2.py

.PHONY: clean
clean:
	stow --verbose --delete --target=$$HOME .
