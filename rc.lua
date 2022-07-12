-------------------------------------------------------
--/=================================================\--
--|>                    RC.LUA                     <|--
--\=================================================/--
-------------------------------------------------------
pcall(require, "luarocks.loader")
--<~>--
local naughty = require("naughty")
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, and error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)
--<~>--
local beautiful = require("beautiful")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/theme.lua")
--<~>--
require("main")
require("widgets")
