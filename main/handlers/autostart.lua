-------------------------------------------------------
--/=================================================\--
--|>                   AUTOSTART                   <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
--<~>--
--awful.spawn.with_shell("~/.config/polybar/launch.sh&")
-- awful.spawn.with_shell("mpd ~/.config/mpd/mpd.conf &")
awful.spawn.with_shell("xset r rate 175 60")
awful.spawn.with_shell("ibus-daemon -drx")
awful.spawn.with_shell("pkill imwheel && imwheel -b 0 || imwheel -b 0")
-- awful.spawn.with_shell("picom -b --config ~/.dots/home/.config/picom/picom.conf --experimental-backends")
