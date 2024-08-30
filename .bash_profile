if [ "$(tty)" = "/dev/tty1" ]; then
	export XDG_SESSION_TYPE=wayland
	# export XDG_SESSION_DESKTOP=sway
	export XDG_CURRENT_DESKTOP=sway
	export MOZ_ENABLE_WAYLAND=1

	export QT_QPA_PLATFORM=wayland-egl
	export CLUTTER_BACKEND=wayland
	export ECORE_EVAS_ENGINE=wayland-egl
	export ELM_ENGINE=wayland_egl
	export SDL_VIDEODRIVER=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1
	export NO_AT_BRIDGE=1
	export QT_QPA_PLATFORMTHEME=qt5ct

	# export GTK_USE_PORTAL=0
	# export XDG_CURRENT_DESKTOP=GNOME

	unsupported_gpu=""
	if grep -qE "^nvidia" /proc/modules; then
		export WLR_NO_HARDWARE_CURSORS=1
		unsupported_gpu="--unsupported-gpu"
	fi

	systemctl --user start sway-session.target
	systemd-cat --identifier=sway sway $unsupported_gpu $@
fi

source "$HOME/.bashrc"
