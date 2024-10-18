DIR = \
	$$HOME/mail/.cache/neomutt.msg \
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

ifneq ($(shell id -u), 0)
  SUDO := $(SUDO)
else
  SUDO :=
endif

ifneq (, $(shell which zypper 2>/dev/null))
  DISTRO := suse
  INSTALL_CMD := zypper install
else ifneq (, $(shell which apt 2>/dev/null))
  DISTRO := debian
  INSTALL_CMD := apt install
else
  $(error "Distribution not supported")
endif

DEPS_DIR := .deps/$(DISTRO)

.PHONY: all
all: base links

.PHONY: links
links:
	mkdir -p $(DIR)
	@if [ -e $$HOME/.bashrc ] && [ ! -L $$HOME/.bashrc ]; then \
		mv $$HOME/.bashrc $$HOME/.bashrc.bak; \
	fi
	stow --verbose --restow --target=$$HOME .
	touch $$HOME/.config/neomutt/aliases

.PHONY: base
base:
	git submodule update --init --recursive
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/base)
	gpg --keyserver hkps://keyserver.ubuntu.com --recv-key 030A8E9E424EE3C0655787E1C90B8A7C638658A6

ifeq ($(DISTRO),debian)
	$(SUDO) update-alternatives --config editor
	$(SUDO) update-alternatives --config vi
endif

.PHONY: dev
dev:
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/dev)

	$(SUDO) update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 40
	$(SUDO) update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 40
ifeq ($(DISTRO),debian)
	$(SUDO) update-alternatives --config vi
endif

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file $$HOME/.config/tmux/tmux.conf || true
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

	$$HOME/.local/share/nvim/mason/packages/vale/vale --config=$HOME/.config/vale/.vale.ini sync

.PHONY: flatpak
flatpak:
	- $(SUDO) $(INSTALL_CMD) flatpak
	- flatpak install flathub $$(tr "\n" " " < $(DEPS_DIR)/flatpak)

.PHONY: wm
wm: flatpak
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/wm)
	fc-cache


ifeq ($(DISTRO),suse)
	$(SUDO) ln -sf /usr/share/terminfo/f/foot-extra /usr/share/terminfo/f/foot
	# printer
	$(SUDO) systemctl enable cups
	$(SUDO) systemctl enable avahi-daemon
	# $(SUDO) systemctl disable firewalld
	# multimedia
	$(SUDO) zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/ openSUSE_Tumbleweed/ packman
	$(SUDO) zypper refresh
	$(SUDO) zypper dup --from packman --allow-vendor-change
	$(SUDO) zypper install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
	# nvidia
	$(SUDO) zypper install nvidia-drivers-G06
	# firefox reading profile
	sed 's/^Name=.*/Name=Firefox (Reading)/; s/^Exec=.*/Exec=firefox %u -P reading/' /usr/share/applications/firefox.desktop > $$HOME/.local/share/applications/firefox-reading.desktop
endif

.PHONY: autologin
autologin:
	$(SUDO) mkdir -p /etc/systemd/system/getty@tty1.service.d
	echo "[Service]" | $(SUDO) tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=" | $(SUDO) tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $$(whoami) %I \$$TERM" | $(SUDO) tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	$(SUDO) systemctl set-default multi-user.target

.PHONY: desktop
desktop: wm autologin
	echo "include config.d/$(DISTRO)/desktop" > $$HOME/.config/sway/autoload

.PHONY: nouveau
nouveau:
ifeq ($(DISTRO),suse)
	$(SUDO) mv /etc/zypp/services.d/NVIDIA.service /etc/zypp/services.d/NVIDIA.service.bak
	$(SUDO) zypper rm $$(zypper se -i | grep nvidia | awk '{print $$3}') || true
	$(SUDO) zypper mr -d $$(zypper lr | awk -F '|' '{IGNORECASE=1} /nvidia/ {print $$2}') || true
	$(SUDO) zypper in kernel-firmware-nvidia
	echo "blacklist nvidia" | $(SUDO) tee /etc/modprobe.d/60-blacklist.conf
	echo "blacklist amdgpu" | $(SUDO) tee -a /etc/modprobe.d/60-blacklist.conf
	$(SUDO) dracut --force
	echo GRUB_CMDLINE_LINUX="nvidia-drm.modeset=0" | $(SUDO) tee -a /etc/default/grub
	$(SUDO) grub2-mkconfig -o /boot/grub2/grub.cfg
endif

.PHONY: laptop
laptop: wm autologin
	echo "include config.d/$(DISTRO)/laptop" > $$HOME/.config/sway/autoload

.PHONY: mail
mail:
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/mail)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O $$HOME/.local/bin/oauth2.py
	chmod +x $$HOME/.local/bin/oauth2.py

.PHONY: clean
clean:
	stow --verbose --delete --target=$$HOME .
