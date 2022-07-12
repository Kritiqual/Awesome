--/===========\--
--|---RULES---|--
--\===========/--
local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("keys")
--{{{
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = keys.clientkeys,
            buttons = keys.clientbuttons,
            -- screen = awful.screen.preferred,
            screen = awful.screen.focused,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            maximized = false,
            titlebars_enabled = beautiful.titlebars_enabled,
            maximized_horizontal = false,
            maximized_vertical = false,
            placement = floating_client_placement,
        },
    },
    -- Floating clients
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "floating_terminal",
                "riotclientux.exe",
                "leagueclientux.exe",
                "Devtools", -- Firefox devtools
            },
            class = {
                "Grub-customizer",
                "Lxappearance",
                "Nm-connection-editor",
                "File-roller",
                "fst",
                "Nvidia-settings",
            },
            name = {
                "Event Tester", -- xev
                "MetaMask Notification",
            },
            role = {
                "AlarmWindow",
                "pop-up",
                "GtkFileChooserDialog",
                "conversation",
            },
            type = {
                "dialog",
            },
        },
        properties = { floating = true },
    },
    -- Fullscreen clients
    {
        rule_any = {
            class = {
                "csgo_linux64",
                "EtG.x86_64",
                "factorio",
                "dota2",
                "Terraria.bin.x86",
                "dontstarve_steam",
            },
        },
        properties = { fullscreen = true },
    },
    -- -- Unfocusable clients (unless clicked with the mouse)
    -- -- If you want to prevent focusing even when clicking them, you need to
    -- -- modify the left click client mouse bind in keys.lua
    -- {
    --     rule_any = {
    --         class = {
    --             "scratchpad"
    --         },
    --     },
    --     properties = { focusable = false }
    -- },
    -- Centered clients
    {
        rule_any = {
            type = {
                "dialog",
            },
            class = {
                "Steam",
                "discord",
                "music",
                "markdown_input",
                "scratchpad",
            },
            instance = {
                "music",
                "markdown_input",
                "scratchpad",
            },
            role = {
                "GtkFileChooserDialog",
                "conversation",
            },
        },
        properties = { placement = centered_client_placement },
    },
    -- Titlebars OFF (explicitly)
    {
        rule_any = {
            instance = {
                "install league of legends (riot client live).exe",
                "gw2-64.exe",
                "battle.net.exe",
                "riotclientservices.exe",
                "leagueclientux.exe",
                "riotclientux.exe",
                "leagueclient.exe",
                "^editor$",
                "markdown_input",
            },
            class = {
                "discord",
                "TelegramDesktop",
                "firefox",
                "Nightly",
                "Steam",
                "Lutris",
                "Google-chrome",
                "^editor$",
                "markdown_input",
            },
            type = {
                "splash",
            },
            name = {
                "^discord.com is sharing your screen.$", -- Discord (running in browser) screen sharing popup
            },
        },
        callback = function(c)
            decorations.hide(c)
        end,
    },
    -- Titlebars ON (explicitly)
    {
        rule_any = {
            type = {
                "dialog",
            },
            role = {
                "conversation",
            },
        },
        callback = function(c)
            titlebars.show(c)
        end,
    },
    -- "Needy": Clients that steal focus when they are urgent
    {
        rule_any = {
            class = {
                "TelegramDesktop",
                "firefox",
                "Nightly",
            },
            type = {
                "dialog",
            },
        },
        callback = function(c)
            c:connect_signal("property::urgent", function()
                if c.urgent then
                    c:jump_to()
                end
            end)
        end,
    },
    -- Fixed terminal geometry for floating terminals
    {
        rule_any = {
            class = {
                "Alacritty",
                "kitty",
            },
        },
        properties = { width = screen_width * 0.45, height = screen_height * 0.5 },
    },
    -- {
    --     -- Visualizer
    --     rule_any = {class = {"Visualizer"}},
    --     properties = {
    --         floating = true,
    --         maximized_horizontal = true,
    --         sticky = true,
    --         ontop = false,
    --         skip_taskbar = true,
    --         below = true,
    --         focusable = false,
    --         height = screen_height * 0.40,
    --         opacity = 0.6,
    --         titlebars_enabled = false
    --     },
    --     callback = function(c)
    --         awful.placement.bottom(c)
    --     end
    -- },
    -- File chooser dialog
    {
        rule_any = { role = { "GtkFileChooserDialog" } },
        properties = { floating = true, width = screen_width * 0.55, height = screen_height * 0.65 },
    },
    -- Pavucontrol
    {
        rule_any = { class = { "Pavucontrol" } },
        properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.8 },
    },
    -- Qalculate
    {
        rule_any = { class = { "Qalculate-gtk" } },
        except_any = { type = { "dialog" } },
        properties = { floating = true, width = screen_width * 0.2, height = screen_height * 0.4 },
    },
    -- File managers
    {
        rule_any = {
            class = {
                -- "Nemo",
                "Thunar",
            },
        },
        except_any = {
            type = { "dialog" },
        },
        properties = { floating = true, width = screen_width * 0.45, height = screen_height * 0.55 },
    },
    -- Screenruler
    {
        rule_any = { class = { "Screenruler" } },
        properties = { border_width = 0, floating = true, ontop = true, titlebars_enabled = false },
        callback = function(c)
            awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
        end,
    },
    -- -- Keepass
    -- {
    --     rule_any = {class = {"KeePassXC"}},
    --     except_any = {name = {"KeePassXC-Browser Confirm Access"}, type = {"dialog"}},
    --     properties = {floating = true, width = screen_width * 0.7, height = screen_height * 0.75}
    -- },
    -- Scratchpad
    {
        rule_any = {
            instance = {
                "scratchpad",
                "markdown_input",
            },
            class = {
                "scratchpad",
                "markdown_input",
            },
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = screen_width * 0.7,
            height = screen_height * 0.75,
        },
    },
    -- Markdown input
    {
        rule_any = {
            instance = {
                "markdown_input",
            },
            class = {
                "markdown_input",
            },
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = screen_width * 0.5,
            height = screen_height * 0.7,
        },
    },
    -- Music clients (usually a terminal running ncmpcpp)
    {
        rule_any = {
            class = {
                "music",
            },
            instance = {
                "music",
            },
        },
        properties = {
            floating = true,
            width = screen_width * 0.45,
            height = screen_height * 0.50,
        },
    },
    -- Image viewers
    {
        rule_any = {
            class = {
                "feh",
                "Sxiv",
            },
        },
        properties = {
            floating = true,
            width = screen_width * 0.7,
            height = screen_height * 0.75,
        },
        callback = function(c)
            awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
        end,
    },
    -- Dragon drag and drop utility
    {
        rule_any = {
            class = {
                "Dragon-drag-and-drop",
                "Dragon",
            },
        },
        properties = {
            floating = true,
            ontop = true,
            sticky = true,
            width = screen_width * 0.3,
        },
        callback = function(c)
            awful.placement.bottom_right(c, {
                honor_padding = true,
                honor_workarea = true,
                margins = { bottom = beautiful.useless_gap * 2, right = beautiful.useless_gap * 2 },
            })
        end,
    },
    -- Steam guard
    {
        rule = { name = "Steam Guard - Computer Authorization Required" },
        properties = { floating = true },
        -- Such a stubborn window, centering it does not work
        -- callback = function (c)
        --     gears.timer.delayed_call(function()
        --         awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        --     end)
        -- end
    },
    -- "Fix" games that minimize on focus loss.
    {
        -- Usually this can be fixed by launching them with
        -- SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0 but not all games use SDL
        rule_any = {
            instance = {
                "synthetik.exe",
            },
        },
        properties = {},
        callback = function(c)
            -- Unminimize automatically
            c:connect_signal("property::minimized", function()
                if c.minimized then
                    c.minimized = false
                end
            end)
        end,
    },
    -- League of Legends client QoL fixes
    {
        rule = { instance = "league of legends.exe" },
        properties = {},
        callback = function(c)
            local matcher = function(c)
                return awful.rules.match(c, { instance = "leagueclientux.exe" })
            end
            -- Minimize LoL client after game window opens
            for c in awful.client.iterate(matcher) do
                c.urgent = false
                c.minimized = true
            end

            -- Unminimize LoL client after game window closes
            c:connect_signal("unmanage", function()
                for c in awful.client.iterate(matcher) do
                    c.minimized = false
                end
            end)
        end,
    },
    ---------------------------------------------
    -- Start application on specific workspace --
    ---------------------------------------------
    -- Browsing
    {
        rule_any = {
            class = {
                "firefox",
                "Nightly",
                "Google-chrome",
            },
        },
        except_any = {
            role = { "GtkFileChooserDialog" },
            instance = { "Toolkit" },
            type = { "dialog" },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[1] },
    },
    -- Games
    {
        rule_any = {
            class = {
                "underlords",
                "deadcells",
                "csgo_linux64",
                "EtG.x86_64",
                "factorio",
                "dota2",
                "Terraria.bin.x86",
                "dontstarve_steam",
                "Wine",
            },
            instance = {
                "leagueclient.exe",
                "glyphclientapp.exe",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[2] },
    },
    -- Chatting
    {
        rule_any = {
            class = {
                "discord",
                "TelegramDesktop",
                "TeamSpeak 3",
                "zoom",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[3] },
    },
    -- Editing
    {
        rule_any = {
            class = {
                "^editor$",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[4] },
    },
    -- System monitoring
    {
        rule_any = {
            class = {
                "bpytop",
                "htop",
            },
            instance = {
                "bpytop",
                "htop",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[5] },
    },
    -- Image editing
    {
        rule_any = {
            class = {
                "Gimp",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[6] },
    },
    -- Game clients/launchers
    {
        rule_any = {
            class = {
                "Steam",
                "battle.net.exe",
                "Lutris",
            },
            name = {
                "Steam",
            },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[8] },
    },
    -- Miscellaneous
    {
        rule_any = {
            class = {
                "qbittorrent",
                "VirtualBox Manager",
                -- "KeePassXC"
            },
            instance = {
                "qbittorrent",
                "qemu",
            },
        },
        except_any = {
            type = { "dialog" },
        },
        properties = { screen = 1, tag = awful.screen.focused().tags[10] },
    },
}
--}}}
