--/========\--
--|--KEYS--|--
--\========/--
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local helpers = require("helpers")

local hotkeys_popup = require("awful.hotkeys_popup")

modkey = "Mod4"
altkey = "Mod1"
shiftkey = "Shift"
ctrlkey = "Ctrl"

local keys = {}
-- Initial Status of top-bar
barVisible = true
-- {{{ Mouse bindings
mymainmenu = awful.menu({
    items = {
        {
            "hotkeys",
            function()
                hotkeys_popup.show_help(nil, awful.screen.focused())
            end,
        },
        { "restart", awesome.restart },
        {
            "quit",
            function()
                awesome.quit()
            end,
        },
        {
            "terminal",
            function()
                awful.spawn(user.terminal)
            end,
        },
    },
})
local function finder(c)
    if c.instance:lower() or c.class:lower() == client then
        c:jump_to()
        return true
    else
        return false
    end
end
keys.desktopbuttons = --{{{
    gears.table.join(
        -- awful.button(
        --     {},
        --     1,
        --     function()
        --         -- Single tap
        --         awesome.emit_signal("elemental::dismiss")
        --         naughty.destroy_all_notifications()
        --         if mymainmenu then
        --             mymainmenu:hide()
        --         end
        --         if sidebar_hide then
        --             sidebar_hide()
        --         end
        --         -- Double tap
        --         local function double_tap()
        --             uc = awful.client.urgent.get()
        --             -- If there is no urgent client, go back to last tag
        --             if uc == nil then
        --                 awful.tag.history.restore()
        --             else
        --                 awful.client.urgent.jumpto()
        --             end
        --         end
        --         helpers.single_double_tap(
        --             function()
        --             end,
        --             double_tap
        --         )
        --     end
        -- ),
        -- Right click - Show app drawer
        awful.button({}, 3, function()
            mymainmenu:toggle()
        end),
        awful.button({}, "7", function()
            naughty.destroy_all_notifications()
            naughty.notification({
                title = "Mouse debug",
                message = "▲ 7 ▲ pressed",
                timeout = 1,
            })
        end),
        awful.button({}, "6", function()
            naughty.destroy_all_notifications()
            naughty.notification({
                title = "Mouse debug",
                message = "▼ 6 ▼ pressed",
                timeout = 1,
            })
        end)
        -- awful.button(
        --     {},
        --     3,
        --     function()
        --         if app_drawer_show then
        --             app_drawer_show()
        --         end
        --     end
        -- ),
        -- -- Middle button - Toggle dashboard
        -- awful.button(
        --     {},
        --     2,
        --     function()
        --         if dashboard_show then
        --             dashboard_show()
        --         end
        --     end
        -- ),
        -- -- Scrolling - Switch tags
        -- awful.button({}, 4, awful.tag.viewprev),
        -- awful.button({}, 5, awful.tag.viewnext),
        -- -- Side buttons - Control volume
        -- awful.button(
        --     {},
        --     9,
        --     function()
        --         helpers.volumectl(5)
        --     end
        -- ),
        -- awful.button(
        --     {},
        --     8,
        --     function()
        --         helpers.volumectl(-5)
        --     end
        -- )

        -- Side buttons - Minimize and restore minimized client
        -- awful.button({ }, 8, function()
        --     if client.focus ~= nil then
        --         client.focus.minimized = true
        --     end
        -- end),
        -- awful.button({ }, 9, function()
        --       local c = awful.client.restore()
        --       -- Focus restored client
        --       if c then
        --           client.focus = c
        --       end
        -- end)
    )
--}}}

--{{{ Key bindings
keys.globalkeys = gears.table.join(
    --[[ awful.key({}, "XF86LaunchA", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Mouse debug",
            message = "A pressed",
            timeout = 1,
        })
    end),
    awful.key({}, "XF86LaunchB", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Mouse debug",
            message = "B pressed",
            timeout = 1,
        })
    end),
    awful.key({ modkey }, "e", function()
        awful.spawn.with_shell("ibus emoji")
    end, { description = "open emoji selection", group = "launcher" }),
    -- Focus screen by index (Uncomment for multi-monitor) {{{
    awful.key(
        {modkey, ctrlkey},
        "j",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        {modkey, ctrlkey},
        "k",
        function()
            awful.screen.focus_relative(-1)
        end,
        {description = "focus the previous screen", group = "screen"}
    ), --}}} --]]
    -- Focus client by direction {{{
    -- hjkl keys
    awful.key({ modkey }, "j", function()
        awful.client.focus.bydirection("down")
    end, { description = "focus down", group = "client" }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.bydirection("up")
    end, { description = "focus up", group = "client" }),
    awful.key({ modkey }, "h", function()
        awful.client.focus.bydirection("left")
    end, { description = "focus left", group = "client" }),
    awful.key({ modkey }, "l", function()
        awful.client.focus.bydirection("right")
    end, { description = "focus right", group = "client" }),
    -- arrow keys
    awful.key({ modkey }, "Down", function()
        awful.client.focus.bydirection("down")
    end, { description = "focus down", group = "client" }),
    awful.key({ modkey }, "Up", function()
        awful.client.focus.bydirection("up")
    end, { description = "focus up", group = "client" }),
    awful.key({ modkey }, "Left", function()
        awful.client.focus.bydirection("left")
    end, { description = "focus left", group = "client" }),
    awful.key({ modkey }, "Right", function()
        awful.client.focus.bydirection("right")
    end, { description = "focus right", group = "client" }), --}}}
    -- -- Window switcher {{{
    -- awful.key(
    --     {modkey},
    --     "Tab",
    --     function()
    --         window_switcher_show(awful.screen.focused())
    --     end,
    --     {description = "activate window switcher", group = "client"}
    -- ), --}}}
    -- Focus client by index (cycle through clients) {{{
    awful.key({ modkey }, "z", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),
    awful.key({ modkey, shiftkey }, "z", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus next by index", group = "client" }), --}}}
    -- Gaps {{{
    awful.key({ modkey }, "equal", function()
        awful.tag.incgap(5, nil)
    end, { description = "increment gaps size for the current tag", group = "gaps" }),
    awful.key({ modkey }, "minus", function()
        awful.tag.incgap(-5, nil)
    end, { description = "decrement gap size for the current tag", group = "gaps" }), --}}}
    -- Resize focused client or layout factor {{{
    -- arrow keys
    awful.key({ modkey, ctrlkey }, "Down", function()
        helpers.resizer(client.focus, "down")
    end),
    awful.key({ modkey, ctrlkey }, "Up", function()
        helpers.resizer(client.focus, "up")
    end),
    awful.key({ modkey, ctrlkey }, "Left", function()
        helpers.resizer(client.focus, "left")
    end),
    awful.key({ modkey, ctrlkey }, "Right", function()
        helpers.resizer(client.focus, "right")
    end),
    -- hjkl keys
    awful.key({ modkey, ctrlkey }, "j", function()
        helpers.resizer(client.focus, "down")
    end),
    awful.key({ modkey, ctrlkey }, "k", function()
        helpers.resizer(client.focus, "up")
    end),
    awful.key({ modkey, ctrlkey }, "h", function()
        helpers.resizer(client.focus, "left")
    end),
    awful.key({ modkey, ctrlkey }, "l", function()
        helpers.resizer(client.focus, "right")
    end),
    -- awful.key({ modkey, ctrlkey }, "c", function()
    --     awful.client.run_or_raise("firefox", function(c)
    --         return awful.rules.match(c, { class = "firefox" })
    --     end)
    -- end, { description = "Run or raise discord", group = "launcher" }),
    awful.key({ modkey, shiftkey }, "c", function()
        helpers.RoS("caprine")
    end, { description = "Run or raise caprine", group = "launcher" }),
    awful.key({ modkey, shiftkey }, "v", function()
        awful.spawn.with_shell("kitty -e nvim")
    end, { description = "Run or neovim", group = "launcher" }),
    awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "w", function()
        mymainmenu:show()
    end, { description = "show main menu", group = "awesome" }),
    awful.key({ modkey }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),
    -- Spawn terminal {{{
    awful.key({ modkey }, "Return", function()
        awful.spawn(user.terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey, shiftkey }, "Return", function()
        awful.spawn(user.floating_terminal, {
            floating = true,
            placement = awful.placement.centered,
        })
    end, { description = "spawn floating terminal", group = "launcher" }),
    awful.key({ modkey }, "u", function()
        helpers.single_double_tap(nil)
    end),
    --}}}
    -- Reload, Quit Awesome {{{
    awful.key({ modkey, ctrlkey }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, shiftkey }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    -- awful.key(
    --     {modkey},
    --     "x",
    --     function()
    --         exit_screen_show()
    --     end,
    --     {description = "quit awesome", group = "awesome"}
    -- ),
    -- awful.key(
    --     {modkey},
    --     "Escape",
    --     function()
    --         exit_screen_show()
    --     end,
    --     {description = "quit awesome", group = "awesome"}
    -- ),
    -- awful.key(
    --     {},
    --     "XF86PowerOff",
    --     function()
    --         exit_screen_show()
    --     end,
    --     {description = "quit awesome", group = "awesome"}
    -- ), --}}}
    -- -- Run or Search {{{
    -- awful.key(
    --     {modkey},
    --     "r",
    --     function()
    --         -- Not all sidebars have a prompt
    --         if sidebar_activate_prompt then
    --             sidebar_activate_prompt("run")
    --         end
    --     end,
    --     {description = "activate sidebar run prompt", group = "awesome"}
    -- ),
    -- awful.key(
    --     {modkey, altkey},
    --     "r",
    --     function()
    --         -- Not all sidebars have a prompt
    --         if sidebar_activate_prompt then
    --             sidebar_activate_prompt("web_search")
    --         end
    --     end,
    --     {description = "activate sidebar web search prompt", group = "awesome"}
    -- ), }}}
    -- XF86 keys {{{
    -- awful.key({}, "XF86AudioStop", function()
    --     awful.spawn.with_shell("bash -c lock")
    -- end, {description = "Lock computer", group = "XF86"}),
    awful.key({}, "XF86MonBrightnessDown", function()
        helpers.brightctl(-10)
    end, { description = "decrease brightness", group = "XF86" }),
    awful.key({}, "XF86MonBrightnessUp", function()
        helpers.brightctl(10)
    end, { description = "increase brightness", group = "XF86" }),
    awful.key({}, "XF86AudioMute", function()
        helpers.volumectl(0)
    end, { description = "(un)mute volume", group = "XF86" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        helpers.volumectl(-2)
    end, { description = "lower volume", group = "XF86" }),
    awful.key({}, "XF86AudioRaiseVolume", function()
        helpers.volumectl(2)
    end, { description = "raise volume", group = "XF86" }),
    awful.key({}, "XF86Mail", function()
        helpers.brightctl(0)
    end, { description = "set brightness to 10", group = "XF86" }),
    -- awful.key({}, "XF86AudioStop", function()
    --     helpers.brightctl(1)
    -- end, { description = "Set brightness to MAX", group = "XF86" }),
    awful.key({}, "XF86Calculator", function()
        helpers.brightctl(-10)
    end, { description = "decrease brightness", group = "XF86" }),
    awful.key({}, "XF86Tools", function()
        helpers.brightctl(10)
    end, { description = "increase brightness", group = "XF86" }),
    --}}}
    -- Screenshots {{{
    awful.key({}, "Print", function()
        helpers.screenshot("full")
    end, { description = "full screenshot", group = "screenshots" }),
    awful.key({ ctrlkey }, "Print", function()
        helpers.screenshot("selection")
    end, { description = "selected area screenshot", group = "screenshots" }),
    awful.key({ shiftkey }, "Print", function()
        helpers.screenshot("clipboard")
    end, { description = "selected area clipboard screenshot", group = "screenshots" }), --}}}
    -- Media keys {{{
    awful.key({ modkey }, "period", function()
        awful.spawn.with_shell("mpc -q next")
    end, { description = "next song", group = "media" }),
    awful.key({ modkey }, "comma", function()
        awful.spawn.with_shell("mpc -q prev")
    end, { description = "previous song", group = "media" }),
    awful.key({ modkey }, "slash", function()
        awful.spawn.with_shell("mpc -q toggle")
    end, { description = "toggle pause/play", group = "media" }),
    awful.key({ modkey, shiftkey }, "period", function()
        awful.spawn.with_shell("mpvc next")
    end, { description = "mpv next song", group = "media" }),
    awful.key({ modkey, shiftkey }, "comma", function()
        awful.spawn.with_shell("mpvc prev")
    end, { description = "mpv previous song", group = "media" }),
    awful.key({ modkey, shiftkey }, "slash", function()
        awful.spawn.with_shell("mpvc toggle")
    end, { description = "mpv toggle pause/play", group = "media" }), --}}}
    -- Number of clients {{{
    -- master
    awful.key({ modkey, altkey }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "Left", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "Right", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    -- columns
    awful.key({ modkey, altkey }, "k", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "j", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "Up", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "Down", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }), --}}
    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),
    awful.key({ modkey, shiftkey }, "space", function()
        awful.layout.inc(-1)
    end, { description = "select previous", group = "layout" }),
    -- Menubar
    awful.key({ modkey }, "p", function()
        require("menubar").show()
    end, { description = "show the menubar", group = "launcher" })
)

keys.clientkeys = gears.table.join(
    -- Test
    --<~>--
    awful.key({ modkey, shiftkey, ctrlkey }, "j", function(c)
        c:relative_move(0, dpi(20), 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "k", function(c)
        c:relative_move(0, dpi(-20), 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "h", function(c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "l", function(c)
        c:relative_move(dpi(20), 0, 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "Down", function(c)
        c:relative_move(0, dpi(20), 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "Up", function(c)
        c:relative_move(0, dpi(-20), 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "Left", function(c)
        c:relative_move(dpi(-20), 0, 0, 0)
    end),
    awful.key({ modkey, shiftkey, ctrlkey }, "Right", function(c)
        c:relative_move(dpi(20), 0, 0, 0)
    end),
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, ctrlkey }, "c", function(c)
        c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
        { modkey, ctrlkey },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, ctrlkey }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c)
        c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, shiftkey }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "(un)maximize", group = "client" }),
    awful.key({ modkey, ctrlkey }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = "(un)maximize vertically", group = "client" }),
    awful.key({ modkey, shiftkey }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys = gears.table.join(
        keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, ctrlkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, shiftkey }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrlkey, shiftkey }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

keys.clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end),

    awful.button({}, "7", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Mouse debug",
            message = "▲ 7 ▲ pressed",
            timeout = 1,
        })
    end),
    awful.button({}, "6", function()
        naughty.destroy_all_notifications()
        naughty.notification({
            title = "Mouse debug",
            message = "▼ 6 ▼ pressed",
            timeout = 1,
        })
    end)
)

-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)
-- }}}

return keys
