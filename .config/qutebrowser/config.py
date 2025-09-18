import os
import catppuccin

# Do not load GUI config
config.load_autoconfig(False)

# Theme
catppuccin.setup(c, 'macchiato', True)

c.url.searchengines = {
# note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
        'DEFAULT': 'https://kagi.com/search?token=Tnesd7uQsAlDHPpURal2dD4zDvfcNqbjRZxyTcve-Bw.BLehd2suwCjIHscBM3VxNI-evAWFFs5MXRU30gG7Zto&q={}',
        '!gw': 'https://wiki.gentoo.org/wiki/?search={}',
        '!gpkg': 'https://packages.gentoo.org/packages/search?q={}',
        '!go': 'https://gpo.zugaina.org/Search?search={}',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
}
c.url.start_pages = "https://kagi.com/search?token=Tnesd7uQsAlDHPpURal2dD4zDvfcNqbjRZxyTcve-Bw.BLehd2suwCjIHscBM3VxNI-evAWFFs5MXRU30gG7Zto"
c.url.default_page = "https://kagi.com/search?token=Tnesd7uQsAlDHPpURal2dD4zDvfcNqbjRZxyTcve-Bw.BLehd2suwCjIHscBM3VxNI-evAWFFs5MXRU30gG7Zto"

# only show tabs when more than 1 tab open
c.tabs.show = "multiple"
c.tabs.position = "left"
c.tabs.title.format = "{audio}{current_title}"
# c.fonts.web.size.default = 20
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
c.tabs.width = '7%'
c.content.autoplay = False

# dark mode setup
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# Bindings
config.bind('<Ctrl-d>', 'config-cycle colors.webpage.darkmode.enabled true false')
config.bind('<Ctrl-m>', 'hint links spawn --detach mpv {hint-url}')
config.bind('<Ctrl-Shift-m>', 'spawn --detach mpv {url}')

c.input.insert_mode.auto_load = True

c.downloads.location.directory = os.getenv('XDG_DOWNLOAD_DIR', '~/Downloads')

# Privacy
config.set("content.webgl", False, "*")
# config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = 'adblock'
