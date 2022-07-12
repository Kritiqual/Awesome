--/======================\--
--|[I] INITIALIZATION [I]|--
--\======================/--
-- {{{
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("keys")
local xrdb = beautiful.xresources.get_current_theme()
local naughty = require("naughty")
require("awful.autofocus")
require("error_handling")
require("rules")
require("layouts")
require("user")
--<~>--
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

-- beautiful.init("/Github/Linux/.config/awesome/themes/theme.lua")
-- -- ===================================================================
-- -- Affects the window appearance: titlebar, titlebar buttons...
-- local decoration_themes = {
--     "lovelace", -- 1 -- Standard titlebar with 3 buttons (close, max, min)
--     "skyfall", -- 2 -- No buttons, only title
--     "ephemeral" -- 3 -- Text-generated titlebar buttons
-- }
-- local decoration_theme = decoration_themes[3]
-- local decorations = require("decorations")
-- decorations.init(decoration_theme)
-- -- ===================================================================
-- -- Statusbar themes. Multiple bars can be declared in each theme.
-- local bar_themes = {
--     "manta", -- 1 -- Taglist, client counter, date, time, layout
--     "lovelace", -- 2 -- Start button, taglist, layout
--     "skyfall", -- 3 -- Weather, taglist, window buttons, pop-up tray
--     "ephemeral", -- 4 -- Taglist, start button, tasklist, and more buttons
--     "amarena" -- 5 -- Minimal taglist and dock with autohide
-- }
-- local bar_theme = bar_themes[5]
-- require("elemental.bar." .. bar_theme)
-- -- ===================================================================
-- -- Affects which icon theme will be used by widgets that display image icons.
-- local icon_themes = {
--     "linebit", -- 1 -- Neon + outline
--     "drops" -- 2 -- Pastel + filled
-- }
-- local icon_theme = icon_themes[2]
-- local icons = require("icons")
-- icons.init(icon_theme)
-- -- ===================================================================
-- local notification_themes = {
--     "lovelace", -- 1 -- Plain with standard image icons
--     "ephemeral", -- 2 -- Outlined text icons and a rainbow stripe
--     "amarena" -- 3 -- Filled text icons on the right, text on the left
-- }
-- local notification_theme = notification_themes[3]
-- local notifications = require("notifications")
-- notifications.init(notification_theme)
-- -- ===================================================================
-- local sidebar_themes = {
--     "lovelace", -- 1 -- Uses image icons
--     "amarena" -- 2 -- Text-only (consumes less RAM)
-- }
-- local sidebar_theme = sidebar_themes[2]
-- require("elemental.sidebar." .. sidebar_theme)
-- -- ===================================================================
-- local dashboard_themes = {
--     "skyfall", -- 1 --
--     "amarena" -- 2 -- Displays coronavirus stats
-- }
-- local dashboard_theme = dashboard_themes[2]
-- require("elemental.dashboard." .. dashboard_theme)
-- -- ===================================================================
-- local exit_screen_themes = {
--     "lovelace", -- 1 -- Uses image icons
--     "ephemeral" -- 2 -- Uses text-generated icons (consumes less RAM)
-- }
-- local exit_screen_theme = exit_screen_themes[2]
-- require("elemental.exit_screen." .. exit_screen_theme)
-- -- ===================================================================
-- local helpers = require("helpers")
-- -- awful.spawn.with_shell(os.getenv("HOME") .. "/Github/Linux/lock.sh")
-- --<~>--
-- require("evil")
-- --}}}
------------------------------------------------------------------------------------------------------------------------------------------------------
--/======================\--
--|[VII] WALLPAPERS [VII]|--
--\======================/--
--{{{
local function set_wallpaper(s)
    if beautiful.wallpaper then
        -- local wallpaper = beautiful.wallpaper
        -- if type(wallpaper) == "function" then
        --     wallpaper = wallpaper(s)
        -- end

        -- Built in function
        -- gears.wallpaper.fit(wallpaper, s, true)
        -- gears.wallpaper.maximized(wallpaper, s, true)

        -- Set with feh
        -- awful.spawn.with_shell("feh --bg-fill " .. wallpaper)
        awful.spawn.with_shell(os.getenv("HOME") .. "/.fehbg")
    end
end
--<~>--
awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)
--<~>--
screen.connect_signal("property::geometry", set_wallpaper)
--}}}
------------------------------------------------------------------------------------------------------------------------------------------------------
--/==================\--
--|[IIIV] TAGS [IIIV]|--
--\==================/--
--{{{
awful.screen.connect_for_each_screen(function(s)
    local l = awful.layout.suit
    local tagnames = beautiful.tagnames or { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }
    awful.tag(tagnames, s, l.max)

    -- Create tags with seperate configuration for each tag
    -- awful.tag.add(tagnames[1], {
    --     layout = layouts[1],
    --     screen = s,
    --     master_width_factor = 0.6,
    --     selected = true,
    -- })
    -- ...
end)
--<~>--
local floating_client_placement = function(c)
    if awful.layout.get(mouse.screen) ~= awful.layout.suit.floating or #mouse.screen.clients == 1 then
        return awful.placement.centered(c, {
            honor_padding = true,
            honor_workarea = true,
        })
    end

    local p = awful.placement.no_overlap + awful.placement.no_offscreen
    return p(c, {
        honor_padding = true,
        honor_workarea = true,
        margins = beautiful.useless_gap * 2,
    })
end
--<~>--
local centered_client_placement = function(c)
    return gears.timer.delayed_call(function()
        awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
    end)
end
--}}}
------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------
--/===============\--
--|[X] SIGNALS [X]|--
--\===============/--
--{{{
client.connect_signal("manage", function(c)
    -- For debugging awful.rules
    -- print('c.class = '..c.class)
    -- print('c.instance = '..c.instance)
    -- print('c.name = '..c.name)

    -- Set every new window as a slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    -- if awesome.startup
    -- and not c.size_hints.user_position
    -- and not c.size_hints.program_position then
    --     awful.placement.no_offscreen(c)
    --     awful.placement.no_overlap(c)
    -- end
end)
--<~>--
client.connect_signal("manage", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

if beautiful.border_width > 0 then
    client.connect_signal("focus", function(c)
        c.border_color = beautiful.border_focus
    end)

    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
    end)
end
--<~>--
awful.mouse.resize.set_mode("live") -- or after
--<~>--
tag.connect_signal("property::layout", function(t)
    for k, c in ipairs(t:clients()) do
        if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
            local cgeo = awful.client.property.get(c, "floating_geometry")
            if cgeo then
                c:geometry(awful.client.property.get(c, "floating_geometry"))
            end
        end
    end
end)

client.connect_signal("manage", function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, "floating_geometry", c:geometry())
    end
end)

client.connect_signal("property::geometry", function(c)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating then
        awful.client.property.set(c, "floating_geometry", c:geometry())
    end
end)

awful.tag.attached_connect_signal(s, "property::selected", function()
    local urgent_clients = function(c)
        return awful.rules.match(c, { urgent = true })
    end
    for c in awful.client.iterate(urgent_clients) do
        if c.first_tag == mouse.screen.selected_tag then
            client.focus = c
        end
    end
end)
--<~>--
client.connect_signal("focus", function(c)
    c:raise()
end)

-- Focus all urgent clients automatically
-- client.connect_signal("property::urgent", function(c)
--     if c.urgent then
--         c.minimized = false
--         c:jump_to()
--     end
-- end)
--<~>--
client.connect_signal("property::floating", function(c)
    if c.floating then
        if c.restore_ontop then
            c.ontop = c.restore_ontop
        end
    else
        c.restore_ontop = c.ontop
        c.ontop = false
    end
end)
--<~>--
-- Disconnect the client ability to request different size and position
-- Breaks fullscreen and maximized
-- client.disconnect_signal("request::geometry", awful.ewmh.client_geometry_requests)
-- client.disconnect_signal("request::geometry", awful.ewmh.geometry)
--<~>--
-- Add `touch /tmp/awesomewm-show-dashboard` to your ~/.xprofile in order to make the dashboard appear on login
local dashboard_flag_path = "/tmp/awesomewm-show-dashboard"
-- Check if file exists
awful.spawn.easy_async_with_shell("stat " .. dashboard_flag_path .. " >/dev/null 2>&1", function(_, __, ___, exitcode)
    if exitcode == 0 then
        -- Show dashboard
        if dashboard_show then
            dashboard_show()
        end
        -- Delete the file
        awful.spawn.with_shell("rm " .. dashboard_flag_path)
    end
end)
--}}}
------------------------------------------------------------------------------------------------------------------------------------------------------
--/============================\--
--|[XI] GARBAGE COLLECTION [XI]|--
--\============================/--
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
