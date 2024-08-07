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
	touch ~/.config/neomutt/aliases

.PHONY: base
base:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/base)
	gpg --recv-key 030A8E9E424EE3C0655787E1C90B8A7C638658A6

ifeq ($(DISTRO),debian)
	sudo update-alternatives --config editor
	sudo update-alternatives --config vi
endif

.PHONY: dev
dev:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/dev)

ifeq ($(DISTRO),debian)
	sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 40
	sudo update-alternatives --config vi
else ifeq ($(DISTRO),suse)
	sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 40 || true
endif

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file $$HOME/.config/tmux/tmux.conf || true
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

.PHONY: flatpak
flatpak:
	- $(INSTALL_CMD) flatpak
	- flatpak install flathub $$(tr "\n" " " < $(DEPS_DIR)/flatpak)

.PHONY: wm
wm: base flatpak
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/wm)
	fc-cache


ifeq ($(DISTRO),suse)
	sudo ln -sf /usr/share/terminfo/f/foot-extra /usr/share/terminfo/f/foot

	# printer
	sudo systemctl enable cups
	sudo systemctl enable avahi-daemon
	# sudo systemctl disable firewalld

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
	sudo systemctl set-default multi-user.target

.PHONY: desktop
desktop: wm autologin
	echo "include config.d/$(DISTRO)/desktop" > $$HOME/.config/sway/autoload

ifeq ($(DISTRO),suse)
	sudo rm /etc/zypp/services.d/NVIDIA.service
	sudo zypper rm $$(zypper se -i | grep nvidia | awk '{print $$3}') || true
	sudo zypper mr -d $$(zypper lr | awk -F '|' '{IGNORECASE=1} /nvidia/ {print $$2}') || true
	echo "blacklist nvidia" | sudo tee /etc/modprobe.d/60-blacklist.conf
	echo "blacklist amdgpu" | sudo tee -a /etc/modprobe.d/60-blacklist.conf
	# echo 'add_dracutmodules+=" bluetooth "' | sudo tee /etc/dracut.conf.d/90-bluetooth.conf
	sudo dracut --force
	# sudo grub2-mkconfig -o /boot/grub2/grub.cfg
endif

.PHONY: laptop
laptop: wm autologin
	echo "include config.d/$(DISTRO)/laptop" > $$HOME/.config/sway/autoload

.PHONY: mail
mail:
	$(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/mail)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O $$HOME/.local/bin/oauth2.py
	chmod +x $$HOME/.local/bin/oauth2.py

.PHONY: clean
clean:
	stow --verbose --delete --target=$$HOME .
