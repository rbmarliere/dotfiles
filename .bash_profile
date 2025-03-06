if [ "$(tty)" = "/dev/tty1" ]; then
	export XDG_SESSION_TYPE=wayland
	# export XDG_CURRENT_DESKTOP=GNOME
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

	# https://github.com/swaywm/sway/wiki#gtk-applications-take-20-seconds-to-start
	export GTK_USE_PORTAL=0

	unsupported_gpu=""
	if grep -qE "^nvidia" /proc/modules; then
		export WLR_NO_HARDWARE_CURSORS=1
		unsupported_gpu="--unsupported-gpu"
	fi

	# systemctl --user start sway-session.target
	# systemd-cat --identifier=sway sway $unsupported_gpu "$@"
	exec sway $unsupported_gpu "$@"
fi

source "$HOME/.bashrc"
