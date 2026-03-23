# Default programs:
export EDITOR="vim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export TERM="st"

# Scaling Settings
export GDK_SCALE=0.75
export GDK_DPI_SCALE=0.75
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=0.75
export CHROME_FLAGS="--force-device-scale-factor=2"

# Most apps use xdg-open not $BROWSER
# to change default xdg-open browser:
# xdg-settings set default-web-browser <browser>.desktop
#
# .desktop files can be found in /usr/share/applications/
# the BROWSER env is used by DWM by pressing MOD+w
export BROWSER="firefox"

# make scrolling in firefox smooth
export MOZ_USE_XINPUT2=1

export PATH="$PATH:~/.npm_install/bin:/home/oliver/.cargo/bin:/usr/local/texlive/2026/bin/x86_64-linux"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="$HOME/.xinitrc"
export XDG_DESKTOP_DIR="$HOME"
# export XDG_DOCUMENTS_DIR="$HOME/documents"
# export XDG_DOWNLOAD_DIR="$HOME/downloads"
# export XDG_PICTURES_DIR="$HOME/pictures"
# export XDG_VIDEOS_DIR="$HOME/videos"
