-------------------------------------------------------
--/=================================================\--
--|>              GLOBAL KEY BINDINGS              <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local gears = require("gears")
local helpers = require("helpers")
local env = require("main.env")
local mod = require("main.bindings.mod")
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height
--<~>--
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
menubar.utils.terminal = env.term
awful.keyboard.append_global_keybindings({
    -- TODO: add keybindings for exitscreen/dock/bar, exitscreen-related,
    -- TODO: and maybe change quit awesome to exitscreen?
    awful.key({ mod.super, mod.ctrl }, "r", awesome.restart, { description = "Restart Awesome", group = "awesome" }),
    awful.key({ mod.super, mod.ctrl }, "q", awesome.quit, { description = "Quit Awesome", group = "awesome" }),
    awful.key({ mod.super }, "p", function()
        menubar.show()
    end),
    awful.key({ mod.super }, "s", hotkeys_popup.show_help),
})
--<~>--
awful.keyboard.append_global_keybindings({
    -------------------------------------------------------
    ----                    Testing                    ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.shift }, "p", function()
        awful.spawn.with_shell("picom -b --experimental-backends --config ~/.dots/home/.config/picom/picom.conf")
    end, { description = "Spawn picom", group = "launcher" }),
    awful.key({ mod.super, mod.ctrl }, "p", function()
        awful.spawn.with_shell("pkill picom")
    end, { description = "Kill picom", group = "launcher" }),
    awful.key({ mod.super, mod.ctrl }, "Return", function()
        awful.spawn("wezterm")
    end),
    -------------------------------------------------------
    ----                Spawn terminal                 ----
    -------------------------------------------------------
    awful.key({ mod.super }, "Return", function()
        awful.spawn(env.term)
    end, { description = "Open a terminal", group = "launcher" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "Return", function()
        awful.spawn(env.fterm, {
            floating = true,
        })
    end, { description = "Open a terminal", group = "launcher" }),
    -------------------------------------------------------
    ----              Spawn file manager               ----
    -------------------------------------------------------
    awful.key({}, "XF86Explorer", function()
        awful.spawn(env.vfm)
    end, { description = "Open visual fm", group = "launcher" }),
    --<~>--
    awful.key({ mod.super }, "e", function()
        awful.spawn(env.fm)
    end, { description = "Open console fm", group = "launcher" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "e", function()
        awful.spawn(env.vfm)
    end, { description = "Open visual fm", group = "launcher" }),
    -------------------------------------------------------
    ----                 Spawn editor                  ----
    -------------------------------------------------------
    awful.key({ mod.super }, "v", function()
        awful.spawn.with_shell(env.editor)
    end, { description = "Open neovim", group = "launcher" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "v", function()
        helpers.RoS(env.veditor)
    end, { description = "Open vscode", group = "launcher" }),
    -------------------------------------------------------
    ----                Spawn chat apps                ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.shift }, "c", function(c)
        helpers.RoS(env.mchat)
    end, { description = "Run or raise caprine", group = "launcher" }),
    awful.key({ mod.super, mod.ctrl }, "c", function(c)
        helpers.RoS(env.dchat)
    end, { description = "Run or raise discord", group = "launcher" }),
    -------------------------------------------------------
    ----            Raise/Spawn other apps             ----
    -------------------------------------------------------
    awful.key({ mod.super }, "b", function()
        helpers.RoS(env.browser)
    end, { description = "Run or raise firefox", group = "launcher" }),
    awful.key({}, "XF86HomePage", function()
        helpers.RoS(env.browser)
    end, { description = "Run or raise firefox", group = "launcher" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "b", function()
        helpers.RoS(env.sys_mon)
    end, { description = "Run or raise bpytop", group = "launcher" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "n", function()
        helpers.RoS(env.music_app)
    end, { description = "Run or raise ncmpcpp", group = "launcher" }),
})
--<~>--
awful.keyboard.append_global_keybindings({
    -------------------------------------------------------
    ----             Focus screen by index             ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.ctrl }, "u", function()
        awful.screen.focus_relative(-1)
    end, { description = "Focus the previous screen", group = "screen" }),
    awful.key({ mod.super, mod.ctrl }, "i", function()
        awful.screen.focus_relative(1)
    end, { description = "Focus the next screen", group = "screen" }),
    -------------------------------------------------------
    ----              Focus urgent client              ----
    -------------------------------------------------------
    awful.key({ mod.super }, "u", function()
        if awful.client.urgent.get() ~= nil then
            awful.client.urgent.jumpto()
        end
    end, { description = "Jump to urgent client", group = "client" }),
    -------------------------------------------------------
    ----        Focus client by arrow/vim keys         ----
    -------------------------------------------------------
    awful.key({ mod.super }, "j", function()
        awful.client.focus.bydirection("down")
    end, { description = "Focus down client", group = "client" }),
    awful.key({ mod.super }, "k", function()
        awful.client.focus.bydirection("up")
    end, { description = "Focus up client", group = "client" }),
    awful.key({ mod.super }, "h", function()
        awful.client.focus.bydirection("left")
    end, { description = "Focus left client", group = "client" }),
    awful.key({ mod.super }, "l", function()
        awful.client.focus.bydirection("right")
    end, { description = "Focus right client", group = "client" }),
    --<~>--
    awful.key({ mod.super }, "Down", function()
        awful.client.focus.bydirection("down")
    end, { description = "Focus down client", group = "client" }),
    awful.key({ mod.super }, "Up", function()
        awful.client.focus.bydirection("up")
    end, { description = "Focus up client", group = "client" }),
    awful.key({ mod.super }, "Left", function()
        awful.client.focus.bydirection("left")
    end, { description = "Focus left client", group = "client" }),
    awful.key({ mod.super }, "Right", function()
        awful.client.focus.bydirection("right")
    end, { description = "Focus right client", group = "client" }),
    -------------------------------------------------------
    ----             Focus client by index             ----
    -------------------------------------------------------
    awful.key({ mod.super }, "z", function()
        awful.client.focus.byidx(1)
    end, { description = "Focus next by index", group = "client" }),
    awful.key({ mod.super, mod.shift }, "z", function()
        awful.client.focus.byidx(-1)
    end, { description = "Focus next by rev-index", group = "client" }),
    -------------------------------------------------------
    ----    Killall visible client for current tag     ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.alt }, "q", function()
        local clients = awful.screen.focused().clients
        for _, c in pairs(clients) do
            c:kill()
        end
    end, { description = "Kill all visible clients", group = "client" }),
    -------------------------------------------------------
    ----               Windows switcher                ----
    -------------------------------------------------------
    awful.key({ mod.super }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),
    -- awful.key({ mod.super }, "Tab", function()
    --     window_switcher_show(awful.screen.focused())
    -- end, { description = "Activate window switcher", group = "client" }),
})
--<~>--
awful.keyboard.append_global_keybindings({
    -------------------------------------------------------
    ----              Change client gaps               ----
    -------------------------------------------------------
    awful.key({ mod.super }, "equal", function()
        awful.tag.incgap(5, nil)
    end, { description = "Increase gaps size for the current tag", group = "gaps" }),
    awful.key({ mod.super }, "minus", function()
        awful.tag.incgap(-5, nil)
    end, { description = "Decrease gap size for the current tag", group = "gaps" }),
    -------------------------------------------------------
    ----   Resize client/layout using arrow/vim keys   ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.ctrl }, "Down", function(c)
        helpers.resizer(client.focus, "down")
    end),
    awful.key({ mod.super, mod.ctrl }, "Up", function(c)
        helpers.resizer(client.focus, "up")
    end),
    awful.key({ mod.super, mod.ctrl }, "Left", function(c)
        helpers.resizer(client.focus, "left")
    end),
    awful.key({ mod.super, mod.ctrl }, "Right", function(c)
        helpers.resizer(client.focus, "right")
    end),
    --<~>--
    awful.key({ mod.super, mod.ctrl }, "j", function(c)
        helpers.resizer(client.focus, "down")
    end),
    awful.key({ mod.super, mod.ctrl }, "k", function(c)
        helpers.resizer(client.focus, "up")
    end),
    awful.key({ mod.super, mod.ctrl }, "h", function(c)
        helpers.resizer(client.focus, "left")
    end),
    awful.key({ mod.super, mod.ctrl }, "l", function(c)
        helpers.resizer(client.focus, "right")
    end),
    -------------------------------------------------------
    ----       Swap client using arrow/vim keys        ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.shift }, "Down", function(c)
        awful.client.swap.bydirection("down", c, nil)
    end, { description = "Swap with down client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "Up", function(c)
        awful.client.swap.bydirection("up", c, nil)
    end, { description = "Swap with up client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "Left", function(c)
        awful.client.swap.bydirection("left", c, nil)
    end, { description = "Swap with left client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "Right", function(c)
        awful.client.swap.bydirection("right", c, nil)
    end, { description = "Swap with right client", group = "client" }),
    --<~>--
    awful.key({ mod.super, mod.shift }, "j", function(c)
        awful.client.swap.bydirection("down", c, nil)
    end, { description = "Swap with down client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "k", function(c)
        awful.client.swap.bydirection("up", c, nil)
    end, { description = "Swap with up client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "h", function(c)
        awful.client.swap.bydirection("left", c, nil)
    end, { description = "Swap with left client", group = "client" }),
    awful.key({ mod.super, mod.shift }, "l", function(c)
        awful.client.swap.bydirection("right", c, nil)
    end, { description = "Swap with right client", group = "client" }),
})
--<~>--
awful.keyboard.append_global_keybindings({
    -------------------------------------------------------
    ----            Change layout by index             ----
    -------------------------------------------------------
    awful.key({ mod.super }, "space", function()
        awful.layout.inc(1)
    end, { description = "Select next layout", group = "layout" }),
    awful.key({ mod.super, mod.shift }, "space", function()
        awful.layout.inc(-1)
    end, { description = "Select previous layout", group = "layout" }),
    -------------------------------------------------------
    ----    Change number of master clients/columns    ----
    -------------------------------------------------------
    awful.key({ mod.super, mod.alt }, "h", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "Increase the number of master clients", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "l", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "Decrease the number of master clients", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "Left", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "Increase the number of master clients", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "Right", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "Decrease the number of master clients", group = "layout" }),
    --<~>--
    awful.key({ mod.super, mod.alt }, "k", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "Increase the number of columns", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "j", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "Decrease the number of columns", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "Up", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "Increase the number of columns", group = "layout" }),
    awful.key({ mod.super, mod.alt }, "Down", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "Decrease the number of columns", group = "layout" }),
})
--<~>--
awful.keyboard.append_global_keybindings({
    -------------------------------------------------------
    ----              Brightness control               ----
    -------------------------------------------------------
    awful.key({}, "XF86MonBrightnessDown", function()
        helpers.brightctl(-10)
    end, { description = "Decrease brightness", group = "XF86" }),
    awful.key({}, "XF86MonBrightnessUp", function()
        helpers.brightctl(10)
    end, { description = "Increase brightness", group = "XF86" }),
    --<~>--
    awful.key({}, "XF86Calculator", function()
        helpers.brightctl(-10)
    end, { description = "Decrease brightness", group = "XF86" }),
    awful.key({}, "XF86Tools", function()
        helpers.brightctl(10)
    end, { description = "Increase brightness", group = "XF86" }),
    --<~>--
    awful.key({}, "XF86Mail", function()
        helpers.brightctl(0)
    end, { description = "Set brightness to 10", group = "XF86" }),
    --<~>--
    -- awful.key({}, "XF86AudioStop", function()
    --     helpers.brightctl(1)
    -- end, { description = "Set brightness to MAX", group = "XF86" }),
    -------------------------------------------------------
    ----                Volume control                 ----
    -------------------------------------------------------
    awful.key({}, "XF86AudioLowerVolume", function()
        helpers.volumectl(-2)
    end, { description = "Lower volume", group = "XF86" }),
    awful.key({}, "XF86AudioRaiseVolume", function()
        helpers.volumectl(2)
    end, { description = "Raise volume", group = "XF86" }),
    awful.key({}, "XF86AudioMute", function()
        helpers.volumectl(0)
    end, { description = "(Un)mute volume", group = "XF86" }),
    -------------------------------------------------------
    ----                 Media control                 ----
    -------------------------------------------------------
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn.with_shell("mpc -q prev")
    end, { description = "Previous song", group = "XF86" }),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn.with_shell("mpc -q next")
    end, { description = "Next song", group = "XF86" }),
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn.with_shell("mpc -q toggle")
    end, { description = "Toggle pause/play", group = "XF86" }),
})
--<~>--
awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { mod.super },
        keygroup = "numrow",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
        { description = "only view tag", group = "tag" },
    }),
    awful.key({
        modifiers = { mod.super, mod.ctrl },
        keygroup = "numrow",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
        { description = "toggle tag", group = "tag" },
    }),
    awful.key({
        modifiers = { mod.super, mod.shift },
        keygroup = "numrow",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        { description = "move focused client to tag", group = "tag" },
    }),
    awful.key({
        modifiers = { mod.super, mod.ctrl, mod.shift },
        keygroup = "numrow",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
        { description = "toggle focused client on tag", group = "tag" },
    }),
    awful.key({
        modifiers = { mod.super },
        keygroup = "numpad",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
        { description = "select layout directly", group = "layout" },
    }),
})
