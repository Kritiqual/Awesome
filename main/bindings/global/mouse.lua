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
    -- awful.button({}, 3, function(c)
    --     -- show_dashboard()
    -- end),
    -------------------------------------------------------
    ----                   SIDE KEYS                   ----
    -------------------------------------------------------
    awful.button({}, "11", function()
        -- show_start()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Global mouse debug",
            message = "▲ 11 ▲ pressed",
            timeout = 1,
        })
    end),
    --<~>--
    awful.button({}, "10", function()
        -- show_runner()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Global mouse debug",
            message = "▼ 10 ▼ pressed",
            timeout = 1,
        })
    end),
})
