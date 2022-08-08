--/=========================\--
--|> USER'S VARIABLES INIT <|--
--\=========================/--
local awful = require("awful")
local styles = {
    "pure",
    "mixed",
}
--<~>--
return {
    chosen_styles = styles[1],
    term = "kitty",
    fterm = "kitty --class fterm",
    veditor = "code",
    editor = "kitty --class editor -o tab_bar_min_tabs=2 --detach nvim",
    vfm = "thunar",
    fm = "kitty --class fm -o tab_bar_min_tabs=2 --detach ranger",
    browser = "firefox",
    mchat = "caprine",
    dchat = "discord",
    music_app = "kitty --class music -o tab_bar_min_tabs=2 --detach ncmpcpp",
    sys_mon = "kitty --class sys_mon -o tab_bar_min_tabs=2 --detach bpytop",
    web_search_cmd = "xdg-open https://google.com/?q=",
    dirs = {
        dl = os.getenv("XDG_DOWNLOAD_DIR") or "~/Downloads",
        dc = os.getenv("XDG_DOCUMENTS_DIR") or "~/Documents",
        ms = os.getenv("XDG_MUSIC_DIR") or "~/Music",
        pt = os.getenv("XDG_PICTURES_DIR") or "~/Pictures",
        vd = os.getenv("XDG_VIDEOS_DIR") or "~/Videos",
        ss = os.getenv("XDG_SCREENSHOTS_DIR") or "~/Pictures/Screenshots",
    },
    layouts = {
        -- awful.layout.suit.floating,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.magnifier,
        awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        awful.layout.suit.tile,
        -- awful.layout.suit.tile.right,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.corner.nw,
        -- awful.layout.suit.corner.ne,
        -- awful.layout.suit.corner.sw,
        -- awful.layout.suit.corner.se,
    },
}
