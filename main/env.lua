--/=========================\--
--|> USER'S VARIABLES INIT <|--
--\=========================/--
local awful = require("awful")
local styles = {
    "pure",
    "mixed",
}
--<~>--
local env = {
    chosen_styles = styles[1],
    term = "kitty -1 --class term",
    fterm = "kitty -1 --class fterm",
    veditor = "code",
    editor = "kitty -1 --class editor --detach nvim",
    vfm = "thunar",
    fm = "kitty -1 --class fm --detach ranger",
    browser = "firefox",
    mchat = "caprine",
    dchat = "discord",
    music_app = "kitty -1 --class music --detach ncmpcpp",
    sys_mon = "kitty -1 --class sys_mon --detach bpytop",
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
--<~>--
return env
