-- --/======================\--
-- --|[I] INITIALIZATION [I]|--
-- --\======================/--
-- -- {{{
-- local gears = require("gears")
-- local awful = require("awful")
-- local beautiful = require("beautiful")
-- local keys = require("keys")
-- local naughty = require("naughty")
-- require("awful.autofocus")
-- require("error_handling")
-- require("rules")
-- require("layouts")
-- require("user")
-- --<~>--

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
beautiful.init("/home/kritiqual/.config/awesome/themes/one_darker/theme.lua")
local xrdb = beautiful.xresources.get_current_theme()
dpi = beautiful.xresources.apply_dpi
x = {
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0 = xrdb.color0,
    color1 = xrdb.color1,
    color2 = xrdb.color2,
    color3 = xrdb.color3,
    color4 = xrdb.color4,
    color5 = xrdb.color5,
    color6 = xrdb.color6,
    color7 = xrdb.color7,
    color8 = xrdb.color8,
    color9 = xrdb.color9,
    color10 = xrdb.color10,
    color11 = xrdb.color11,
    color12 = xrdb.color12,
    color13 = xrdb.color13,
    color14 = xrdb.color14,
    color15 = xrdb.color15,
}
-- Error Handling
require("error_handling")

awesome.set_preferred_icon_size(32)

-- Keybindings
require("keys")

-- UI
require("ui")
-- temp

-- Layouts
require("layouts")

-- Wibar
require("bar")

-- User
require("user")

-- Test
-- require("ctrldock")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- show titlebar of new window
    if c.first_tag.layout.name ~= "floating" then
        awful.titlebar.hide(c)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
function delayFunctionCall(time, c)
    local t = gears.timer({ timeout = time or 0.5 }) --initiate timer
    t:connect_signal("timeout", function()
        t:stop()
        if c == mouse.current_client then
            c:emit_signal("request::activate", "mouse_enter", { raise = true })
        end
    end)
    --focus window
    t:start()
end

client.connect_signal("mouse::enter", function(c) -- gets called when mouse enters client(=window)
    delayFunctionCall(0.25, c)
end)

-- -- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", { raise = true })
-- end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    --     if c.fullscreen then
    --         c.screen.mywibox.ontop = false -- put the wibox in background while window is fullscreen
    --     else
    --         c.screen.mywibox.ontop = true
    --     end
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

-- tag.connect_signal("property::layout", function(t) --hide titlebars while tiling
--     local clients = t:clients()
--     for k, c in pairs(clients) do
--         if c.floating or c.first_tag.layout.name == "floating" then
--             if c.class ~= "Polybar" then
--                 awful.titlebar.show(c)
--             end
--         else
--             awful.titlebar.hide(c)
--         end
--     end
-- end)

tag.connect_signal("property::layout", function(t) --hide all titlebars
    local clients = t:clients()
    for k, c in pairs(clients) do
        awful.titlebar.hide(c)
    end
end)

-- client.connect_signal("property::size", function(c)
--     if c.fullscreen then
--         c.screen.mywibox.ontop = false -- put the wibox in background while window is fullscreen
--     else
--         c.screen.mywibox.ontop = true
--     end

-- end)
-- }}}

-- Autostart Applications
--awful.spawn.with_shell("~/.config/polybar/launch.sh&")
-- awful.spawn.with_shell("mpd ~/.config/mpd/mpd.conf &")
awful.spawn.with_shell("xset r rate 175 60")
awful.spawn.with_shell("ibus-daemon -drx")
awful.spawn.with_shell("pkill imwheel && imwheel -b 0 || imwheel -b 0")
-- awful.spawn.with_shell("picom -b --config ~/.dots/home/.config/picom/picom.conf --experimental-backends")
