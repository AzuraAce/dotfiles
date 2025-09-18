#!/bin/sh

gentoo-pipewire-launcher &
easyeffects --gapplication-service &
# gammastep &
swaybg --output '*' --mode fill --image ~/wallpapers/pokemon_windows_7.jpg & 
mako &
foot --server &
swayidle -w lock 'swaylock' &
mpd &

exec dbus-update-environment WAYLAND_DISPLAY
