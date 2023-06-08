-------------------------------------------------------
--/=================================================\--
--|>            HANDLERS INITIALIZATION            <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
--<~>--
return {
    signals = require("main.handlers.signals"),
    rules = require("main.handlers.rules"),
    awful.spawn.with_shell("~/.config/awesome/main/handlers/autorun.sh"),
}
