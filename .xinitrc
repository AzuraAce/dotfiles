[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

feh --bg-scale -z /home/oliver/wallpapers/2014465.webp
#syncthing &
pipewire &
dwmblocks &
dunst &
#darkman run & # light/dark mode auto switch
#gammastep -l 55.7:12.6 -t 5700:3600 -g 0.8 -m randr &
#udiskie &

exec dbus-run-session dwm
