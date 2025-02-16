DIR = \
	$$HOME/.cache/nvim/bkp \
	$$HOME/.cache/nvim/swp \
	$$HOME/.cache/nvim/und \
	$$HOME/.cache/vim/bkp \
	$$HOME/.cache/vim/swp \
	$$HOME/.cache/vim/und \
	$$HOME/.config/systemd/user \
	$$HOME/.local/bin \
	$$HOME/.local/share/applications \
	$$HOME/mail/.notmuch/.lore \
	$$HOME/mail/.notmuch/hooks \
	$$HOME/src/extra

FILES = \
	$$HOME/.bash_eternal_history \
	$$HOME/.config/nvim/lua/config/priv.lua

ifeq ($(shell id -u), 0)
	SUDO :=
else
	SUDO := sudo
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

REQUIRE_SYSTEMD = @if ! command -v systemctl &> /dev/null; then echo "systemd is required for $@ target"; exit 1; fi

PHONY := all
all: base links

PHONY += links
links:
	mkdir -p $(DIR)
	@if [ -e $$HOME/.bashrc ] && [ ! -L $$HOME/.bashrc ]; then \
		mv $$HOME/.bashrc $$HOME/.bashrc.bak; \
	fi
	stow --verbose --restow --target=$$HOME .
	touch $(FILES)

PHONY += base
base:
	git submodule update --init --recursive
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/base)
	gpg --keyserver hkps://keyserver.ubuntu.com --recv-key 030A8E9E424EE3C0655787E1C90B8A7C638658A6

ifeq ($(DISTRO),debian)
	$(SUDO) update-alternatives --config editor
	$(SUDO) update-alternatives --config vi
else
	sudo ln -sf /usr/bin/vim /usr/bin/vi
endif

PHONY += dev
dev:
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/dev)

	$(SUDO) update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 40
	$(SUDO) update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 40
ifeq ($(DISTRO),debian)
	$(SUDO) update-alternatives --config vi
else
	sudo ln -sf /usr/bin/nvim /usr/bin/vi
endif

	ln -sf $$HOME/.config/tmux/plugins.conf $$HOME/.config/tmux/autoload
	tmux source-file $$HOME/.config/tmux/tmux.conf || true
	$$HOME/.config/tmux/plugins/tpm/bin/install_plugins

	# install plugins and sync vale
	nvim +MasonToolsUpdateSync
	$$HOME/.local/share/nvim/mason/packages/vale/vale --config=$$HOME/.config/vale/.vale.ini sync
	cd $$HOME/.local/share/nvim/mason/packages/prettier && npm install --save-dev prettier-plugin-go-template


PHONY += flatpak
flatpak:
	- $(SUDO) $(INSTALL_CMD) flatpak
	- flatpak install flathub $$(tr "\n" " " < $(DEPS_DIR)/flatpak)

PHONY += wm
wm: flatpak
	$(REQUIRE_SYSTEMD)
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/wm)
	fc-cache
ifeq ($(DISTRO),suse)
	$(SUDO) ln -sf /usr/share/terminfo/f/foot-extra /usr/share/terminfo/f/foot
	# printer
	$(SUDO) systemctl enable cups
	$(SUDO) systemctl enable avahi-daemon
	# $(SUDO) systemctl disable firewalld
	# multimedia
	$(SUDO) zypper ar -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman || true
	$(SUDO) zypper refresh
	$(SUDO) zypper dup --from packman --allow-vendor-change
	$(SUDO) zypper install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
	# nvidia
	# $(SUDO) zypper install nvidia-drivers-G06
	# firefox custom profiles
	sed 's/^Name=.*/Name=Firefox (Reading)/; s/^Exec=.*/Exec=firefox %u -P reading/' /usr/share/applications/firefox.desktop > $$HOME/.local/share/applications/firefox-reading.desktop
	sed 's/^Name=.*/Name=Firefox (Music)/; s/^Exec=.*/Exec=firefox %u -P music/' /usr/share/applications/firefox.desktop > $$HOME/.local/share/applications/firefox-music.desktop
endif

PHONY += autologin
autologin:
	$(REQUIRE_SYSTEMD)
	# https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console
	$(SUDO) mkdir -p /etc/systemd/system/getty@tty1.service.d
	echo "[Service]" | $(SUDO) tee /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=" | $(SUDO) tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	echo "ExecStart=-/sbin/agetty -o '-p -f -- \\\\u' --noclear --autologin $$(whoami) %I \$$TERM" | $(SUDO) tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
	$(SUDO) systemctl set-default multi-user.target

PHONY += desktop
desktop: wm autologin
	echo "include config.d/$(DISTRO)/desktop" > $$HOME/.config/sway/autoload

PHONY += nouveau
nouveau:
ifeq ($(DISTRO),suse)
	# $(SUDO) mv /etc/zypp/services.d/NVIDIA.service /etc/zypp/services.d/NVIDIA.service.bak
	# $(SUDO) zypper rm $$(zypper se -i | grep nvidia | awk '{print $$3}') || true
	$(SUDO) zypper rm openSUSE-repos-Tumbleweed-NVIDIA
	$(SUDO) zypper ms -d NVIDIA
	$(SUDO) zypper mr -d $$(zypper lr | awk -F '|' '{IGNORECASE=1} /nvidia/ {print $$2}') || true
	$(SUDO) zypper in kernel-firmware-nvidia kernel-firmware-nvidia-gspx-G06-cuda
	echo "blacklist nvidia" | $(SUDO) tee /etc/modprobe.d/60-blacklist.conf
	echo "blacklist amdgpu" | $(SUDO) tee -a /etc/modprobe.d/60-blacklist.conf
	$(SUDO) dracut --force --regenerate-all
	echo GRUB_CMDLINE_LINUX="nvidia-drm.modeset=0 nouveau.modeset=1 video=3440x1440" | $(SUDO) tee -a /etc/default/grub
	$(SUDO) update-bootloader
endif

PHONY += laptop
laptop: wm autologin
	echo "include config.d/$(DISTRO)/laptop" > $$HOME/.config/sway/autoload

PHONY += mail
mail:
	$(REQUIRE_SYSTEMD)
	$(SUDO) $(INSTALL_CMD) $$(tr "\n" " " < $(DEPS_DIR)/mail)
	wget https://raw.githubusercontent.com/google/gmail-oauth2-tools/master/python/oauth2.py -O $$HOME/.local/bin/oauth2.py
	chmod +x $$HOME/.local/bin/oauth2.py

	@if [ ! -d $$HOME/src/extra/lieer ]; then \
		$$HOME/.local/bin/clone git@github.com:gauteh/lieer.git $$HOME/src/extra/lieer; \
		python3 -m venv $$HOME/src/extra/lieer/master/venv; \
		source $$HOME/src/extra/lieer/master/venv/bin/activate; \
		python3 -m pip install $$HOME/src/extra/lieer/master; \
	fi

	cp .config/systemd/user/* $$HOME/.config/systemd/user
	systemctl --user enable notmuch
	systemctl --user enable notmuch.timer
	systemctl --user start notmuch.timer

PHONY += clean
clean:
	stow --verbose --delete --target=$$HOME .

PHONY += help
help:
	@echo  'Basic targets:'
	@echo  '  clean		  - Remove all links managed by stow'
	@echo  '  all		  - Build base and links targets, usually for servers'
	@echo  '  links		  - Install the dotfiles links in $HOME using stow'
	@echo  '  base		  - Install base dependencies (.deps/**/base)'
	@echo  '  dev		  - Install development dependencies (.deps/**/dev)'
	@echo  '                    Install tmux and neovim plugins'
	@echo  '  mail		  - Install mail dependencies (.deps/**/mail)'
	@echo  '                    Download gmail oauth2.py helper script'
	@echo  '                    Setup notmuch systemd service'
	@echo  ''
	@echo  'Device specific targets:'
	@echo  '  desktop	  - Build wm and autologin targets'
	@echo  '                    Include desktop sway config in .config/sway/autoload'
	@echo  '  laptop	  - Build wm and autologin targets'
	@echo  '                    Include laptop sway config in .config/sway/autoload'
	@echo  ''
	@echo  'Misc. targets:'
	@echo  '  autologin	  - Setup autologin for the current user in tty1 using systemd'
	@echo  '  flatpak	  - Install flatpak dependencies (.deps/**/flatpak)'
	@echo  '  nouveau	  - Remove nvidia proprietary drivers in favor of nouveau in openSUSE'
	@echo  '  wm		  - Build flatpak target'
	@echo  '                    Install the window manager - sway - dependencies (.deps/**/wm)'

.PHONY: $(PHONY)
