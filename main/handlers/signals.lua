-------------------------------------------------------
--/=================================================\--
--|>                    SIGNALS                    <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local beautiful = require("beautiful")
local env = require("main.env")
require("awful.autofocus")
-------------------------------------------------------
----                Client Signals                 ----
-------------------------------------------------------
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
--<~>--
client.connect_signal("mouse::enter", function(c)
    local t = gears.timer({ timeout = 0.25 })
    t:connect_signal("timeout", function()
        t:stop()
        if c == mouse.current_client then
            c:activate({ context = "mouse_enter", raise = true })
        end
    end)
    t:start()
end)
-- client.connect_signal("mouse::enter", function(c)
--     c:activate({ context = "mouse_enter", raise = true })
-- end)
--<~>--
-- client.connect_signal("property::size", function(c)
--     if c.fullscreen then
--         c.screen.mywibox.ontop = false
--     else
--         c.screen.mywibox.ontop = true
--     end
--<~>--
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    --     if c.fullscreen then
    --         c.screen.mywibox.ontop = false
    --     else
    --         c.screen.mywibox.ontop = true
    --     end
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
--<~>--
tag.connect_signal("property::layout", function(t)
    --hide all titlebars
    local clients = t:clients()
    for k, c in pairs(clients) do
        awful.titlebar.hide(c)
    end
end)
-------------------------------------------------------
----                Naughty signals                ----
-------------------------------------------------------
naughty.connect_signal("request::display", function(n)
    naughty.layout.box({ notification = n })
end)
-------------------------------------------------------
----                Screen signals                 ----
-------------------------------------------------------
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts(env.layouts)
end)
--<~>--
local function set_wallpaper(s)
    -- >> Method 1: Built in wallpaper function
    awful.wallpaper({
        screen = s,
        widget = {
            {
                image = beautiful.wallpaper,
                upscale = true,
                downscale = true,
                widget = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled = false,
            widget = wibox.container.tile,
        },
    })

    -- >> Method 2: Set theme's wallpaper with feh
    --awful.spawn.with_shell("feh --bg-fill " .. wallpaper)

    -- >> Method 3: Set last wallpaper with feh
    -- awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
end
screen.connect_signal("request::wallpaper", set_wallpaper)
screen.connect_signal("property::geometry", set_wallpaper)
--<~>--
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, env.layouts[1])
end)
