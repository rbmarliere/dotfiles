.PHONY: clean all dev desktop laptop mail

DIR = \
	$$HOME/.cache/neomutt/ \
	$$HOME/.cache/nvim/bkp \
	$$HOME/.cache/nvim/swp \
	$$HOME/.cache/nvim/und \
	$$HOME/.cache/vim/bkp \
	$$HOME/.cache/vim/swp \
	$$HOME/.cache/vim/und \
	$$HOME/.config/systemd/user \
	$$HOME/.local/bin \
	$$HOME/.local/share

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

all: links base

links:
	mkdir -p $(DIR)
	stow --verbose --restow --target=$$HOME .

base:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/base)

ifeq ($(DISTRO),suse)
	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 50
else ifeq ($(DISTRO),debian)
	sudo update-alternatives --config editor
endif

	sudo update-alternatives --config vi

dev:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/dev)

	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 40
	sudo update-alternatives --config vi

	ln -sf $$HOME/.config/tmux/tmux.service $$HOME/.config/systemd/user/tmux.service
	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file ~/.config/tmux/tmux.conf
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

wm: base
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/wm)
	fc-cache

	flatpak install flathub $$(tr "\n" " " < $(DEPS_DIR)/flatpak)

	for patch in .patches/*; do \
		target=$$(grep -m 1 '^+++ ' "$$patch" | cut -d ' ' -f 2 | cut -f1); \
		if [ -f "$$target" ]; then \
			echo patching $$target; \
			sudo patch -s -N -r - $$target < $$patch || true; \
		fi \
	done
	git update-index --assume-unchanged .bash_profile

ifeq ($(DISTRO),suse)
	wget https://github.com/hluk/CopyQ/releases/download/v9.0.0/copyq_9.0.0_openSUSE_Leap_15.4.x86_64.rpm -O /tmp/copyq.rpm
	$(INSTALL_CMD) /tmp/copyq.rpm
	rm /tmp/copyq.rpm

	sudo ln -sf /usr/share/terminfo/f/foot-extra /usr/share/terminfo/f/foot

	sudo echo "blacklist nvidia" > /etc/modprobe.d/60-blacklist.conf
	sudo dracut --force
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg

	# printer
	systemctl enable cups
	systemctl enable avahi-daemon
	systemctl disable firewalld

	# zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/ openSUSE_Tumbleweed/ packman
	# zypper dup --from packman --allow-vendor-change
endif

autologin:
	sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
	echo "[Service]" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $$(whoami) %I \$$TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "Environment=XDG_SESSION_TYPE=wayland" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf


desktop: wm autologin
	echo "include config.d/$(DISTRO)/desktop" > $$HOME/.config/sway/autoload

laptop: wm autologin
	echo "include config.d/$(DISTRO)/laptop" > $$HOME/.config/sway/autoload

mail:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/mail)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O ~/.local/bin/oauth2.py
	chmod +x ~/.local/bin/oauth2.py

clean:
	stow --verbose --delete --target=$$HOME .
