-------------------------------------------------------
--/=================================================\--
--|>             GLOBAL MOUSE BINDINGS             <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local naughty = require("naughty")
local mod = require("main.bindings.mod")
--<~>--
awful.mouse.append_global_mousebindings({
    -------------------------------------------------------
    ----                   MAIN KEYS                   ----
    -------------------------------------------------------
    -- awful.button({}, 1, function(c) end),
    -- --<~>--
    -- awful.button({}, 2, function(c) end),
    -- --<~>--
    -- awful.button({}, 3, function(c) end),
    -------------------------------------------------------
    ----                   SIDE KEYS                   ----
    -------------------------------------------------------
    awful.button({}, "7", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Global mouse debug",
            message = "▲ 7 ▲ pressed",
            timeout = 1,
        })
    end),
    --<~>--
    awful.button({}, "6", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Global mouse debug",
            message = "▼ 6 ▼ pressed",
            timeout = 1,
        })
    end),
})
