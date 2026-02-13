[ -f ~/.xprofile ] && . ~/.xprofile
xrdb -merge ~/.Xresources

feh --bg-scale -z /home/oliver/wallpapers/2014465.webp
syncthing &
pipewire &
dwmblocks &
dunst &
# udiskie &

exec dbus-run-session dwm
