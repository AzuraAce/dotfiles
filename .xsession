#!/bin/sh
if [ -x ${PREFIX}/bin/dbus-launch -a -z "${DBUS_SESSION_BUS_ADDRESS}" ]; then
	eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

if [ -f /etc/os-release ]; then
    . /etc/os-release
    [ $NAME == "Gentoo" ] && gentoo-pipewire-launcher &
fi

picom --backend=glx --vsync &
sxhkd &
feh --bg-scale ~/wallpapers/nerv.webp &
slstatus &
dunst &

exec dwm
