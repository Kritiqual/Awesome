-------------------------------------------------------
--/=================================================\--
--|>             CLIENT MOUSE BINDINGS             <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local naughty = require("naughty")
local mod = require("main.bindings.mod")
--<~>--
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        -------------------------------------------------------
        ----                   Main keys                   ----
        -------------------------------------------------------
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        --<~>--
        awful.button({ mod.super }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        --<~>--
        awful.button({ mod.super }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
        -------------------------------------------------------
        ----                   Side keys                   ----
        -------------------------------------------------------
        awful.button({}, "7", function()
            naughty.destroy_all_notifications()
            naughty.notification({
                title = "Client mouse debug",
                message = "▲ 7 ▲ pressed",
                timeout = 1,
            })
        end),
        --<~>--
        awful.button({}, "6", function()
            naughty.destroy_all_notifications()
            naughty.notification({
                title = "Client mouse debug",
                message = "▼ 6 ▼ pressed",
                timeout = 1,
            })
        end),
    })
end)
