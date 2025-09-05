#!/bin/sh

gentoo-pipewire-launcher &
swaybg --output '*' --mode fill --image ~/wallpapers/macOS-Sierra-Wallpaper-Macbook-Wallpaper.jpg & 
mako &
foot --server &

exec dbus-update-environment WAYLAND_DISPLAY
