-------------------------------------------------------
--/=================================================\--
--|>                     RULES                     <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local ruled = require("ruled")
local beautiful = require("beautiful")
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height
--<~>--
ruled.client.connect_signal("request::rules", function()
    -------------------------------------------------------
    ----                 Global rules                  ----
    -------------------------------------------------------
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            raise = true,
            focus = awful.client.focus.filter,
            screen = awful.screen.focused,
            titlebars_enabled = beautiful.titlebars_enabled,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            size_hints_honor = false,
            honor_workarea = true,
            honor_padding = true,
            fullscreen = false,
            maximized = false,
            maximized_vertical = false,
            maximized_horizontal = false,
            placement = awful.placement.floating,
        },
    })
    -------------------------------------------------------
    ----               Floating clients                ----
    -------------------------------------------------------
    ruled.client.append_rule({
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
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
            type = { "dialog" },
        },
        properties = { floating = true },
    })
    -------------------------------------------------------
    ----              Fullscreen clients               ----
    -------------------------------------------------------
    ruled.client.append_rule({
        rule_any = {
            class = {
                "csgo_linux64",
                "EtG.x86_64",
                "factorio",
                "dota2",
                "Terraria.bin.x86_64",
                "tModLoader.bin.x86_64",
                "dontstarve_steam",
            },
        },
        properties = { fullscreen = true },
    })
    -------------------------------------------------------
    ----               Centered clients                ----
    -------------------------------------------------------
    ruled.client.append_rule({
        id = "centered",
        rule_any = {
            type = { "dialog" },
            class = {
                "Steam",
                "discord",
                "music",
                "scratchpad",
            },
            instance = {
                "music",
                "scratchpad",
            },
            role = {
                "GtkFileChooserDialog",
                "conversation",
            },
        },
        properties = { placement = centered_client_placement },
    })
    -------------------------------------------------------
    ----                   Titlebars                   ----
    -------------------------------------------------------
    -- ruled.client.append_rule({
    --     rule_any = {
    --         instance = {
    --             "install league of legends (riot client live).exe",
    --             "gw2-64.exe",
    --             "battle.net.exe",
    --             "riotclientservices.exe",
    --             "leagueclientux.exe",
    --             "riotclientux.exe",
    --             "leagueclient.exe",
    --             "^editor$",
    --         },
    --         class = {
    --             "discord",
    --             "TelegramDesktop",
    --             "firefox",
    --             "Nightly",
    --             "Steam",
    --             "Lutris",
    --             "Google-chrome",
    --             "^editor$",
    --         },
    --         type = {
    --             "splash",
    --         },
    --         name = {
    --             "^discord.com is sharing your screen.$", -- Discord (running in browser) screen sharing popup
    --         },
    --     },
    --     callback = function(c)
    --         decorations.hide(c)
    --     end,
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         type = {
    --             "dialog",
    --         },
    --         role = {
    --             "conversation",
    --         },
    --     },
    --     callback = function(c)
    --         titlebars.show(c)
    --     end,
    -- })
    -------------------------------------------------------
    ----                Urgent clients                 ----
    -------------------------------------------------------
    ruled.client.append_rule({
        rule_any = {
            class = {
                "TelegramDesktop",
                "firefox",
                "Nightly",
            },
            type = { "dialog" },
        },
        callback = function(c)
            c:connect_signal("property::urgent", function()
                if c.urgent then
                    c:jump_to()
                end
            end)
        end,
    })
    -------------------------------------------------------
    ----                 App specific                  ----
    -------------------------------------------------------
    ruled.client.append_rule({
        rule_any = { class = { "Blueman-manager" } },
        properties = {
            floating = true,
            width = screen_width / 3,
            height = screen_height / 3,
            placement = awful.placement.top_left,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "Caprine" } },
        properties = {
            floating = true,
            width = screen_width / 2,
            height = screen_height * 0.6,
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "Dragon-drag-and-drop",
    --             "Dragon",
    --         },
    --     },
    --     properties = {
    --         floating = true,
    --         ontop = true,
    --         sticky = true,
    --         width = screen_width * 0.3,
    --     },
    --     callback = function(c)
    --         awful.placement.bottom_right(c, {
    --             honor_padding = true,
    --             honor_workarea = true,
    --             margins = {
    --                 bottom = beautiful.useless_gap * 2,
    --                 right = beautiful.useless_gap * 2,
    --             },
    --         })
    --     end,
    -- })
    --<~>--
    ruled.client.append_rule({
        rule_any = {
            class = { "Thunar", "fm" },
        },
        except_any = {
            type = { "dialog" },
        },
        properties = {
            floating = true,
            width = screen_width * 0.45,
            height = screen_height * 0.5,
            placement = awful.placement.top_left,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "Gcr-prompter" } },
        properties = {
            floating = true,
            width = screen_width / 4,
            height = screen_height / 5,
            placement = awful.placement.centered,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { role = { "GtkFileChooserDialog" } },
        properties = {
            floating = true,
            width = screen_width * 0.55,
            height = screen_height * 0.65,
            placement = awful.placement.centered,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = {
            class = {
                "Ibus-ui-gtk3",
                "Ibus-setup",
            },
        },
        properties = { floating = true },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    --<~>--
    ruled.client.append_rule({
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
            awful.placement.centered(c, {
                honor_workarea = true,
                honor_padding = true,
            })
        end,
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "kruler" } },
        properties = {
            border_width = 0,
            floating = true,
            maximized_horizontal = true,
            ontop = false,
            titlebars_enabled = false,
            -- hidden = true,
            placement = awful.placement.bottom,
        },
    })
    --<~>--
    ruled.client.append_rule({
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
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "Lxappearance" } },
        properties = {
            floating = true,
            width = screen_width * 0.4,
            height = screen_height * 0.4,
            placement = awful.placement.top_left,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = {
            class = { "music", "sys_mon" },
        },
        properties = {
            floating = true,
            width = screen_width * 0.45,
            height = screen_height * 0.50,
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_workarea = true,
                honor_padding = true,
            })
        end,
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "Pavucontrol" } },
        properties = {
            floating = true,
            width = screen_width / 3,
            height = screen_height / 3,
            placement = awful.placement.top_left,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = {
            class = {
                "qbittorrent",
                "qBittorrent",
            },
        },
        properties = {
            floating = true,
            x = 0,
            y = 0,
            width = screen_width / 3,
            height = screen_height / 3,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = { "Seahorse" } },
        properties = {
            floating = true,
            width = screen_width / 3,
            height = screen_height / 3,
            placement = awful.placement.top_left,
        },
    })
    --<~>--
    ruled.client.append_rule({
        rule = { name = "Steam Guard - Computer Authorization Required" },
        properties = { floating = true },
        -- Such a stubborn window, centering it does not work
        -- callback = function (c)
        --     gears.timer.delayed_call(function()
        --         awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
        --     end)
        -- end
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = {
            class = {
                "Alacritty",
                "kitty",
            },
        },
        properties = {
            width = screen_width * 0.45,
            height = screen_height * 0.5,
        },
    })
    ruled.client.append_rule({
        rule_any = {
            class = { "fterm" },
        },
        properties = {
            floating = true,
            width = screen_width * 0.45,
            height = screen_height * 0.5,
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    --<~>--
    ruled.client.append_rule({
        rule_any = { class = "VirtualBox Machine" },
        properties = {
            floating = true,
            width = 1280,
            height = 1024,
        },
        callback = function(c)
            awful.placement.centered(c, {
                size_hints_honor = false,
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    --<~>--
    -- ruled.client.append_rule({
    --     rule_any = { class = { "Visualizer" } },
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
    --         titlebars_enabled = false,
    --     },
    --     callback = function(c)
    --         awful.placement.bottom(c)
    --     end,
    -- })
    --<~>--
    ruled.client.append_rule({
        rule_any = { name = { "zoom " } },
        except_any = {
            name = {
                "Zoom - Free Account",
                "Zoom Meeting",
            },
        },
        properties = {
            floating = true,
            ontop = false,
            -- hidden = true,
        },
        callback = function(c)
            awful.placement.top_right(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    ruled.client.append_rule({
        rule_any = {
            name = {
                "Chat",
                "Participants",
                "Choose ONE of the audio conference options",
            },
        },
        properties = {
            floating = true,
            width = 420,
            height = 400,
            ontop = false,
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    ruled.client.append_rule({
        rule_any = {
            name = {
                "Zoom - Free Account",
                -- "Settings",
                "Zoom - Personal Meeting ID",
                "Schedule Meeting",
                "Security Settings Overview",
                "Select a window or an aplication that you want to share",
                "Invite people to join meeting",
                "Remove Participant",
            },
        },
        properties = {
            floating = true,
            width = screen_width * 0.5,
            height = screen_height * 0.65,
            ontop = false,
            focusable = true,
            placement = awful.placement.centered,
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true,
            })
        end,
    })
    ruled.client.append_rule({
        rule_any = {
            name = {
                "Invite to Zoom",
            },
        },
        properties = { placement = awful.placement.centered },
    })
    ruled.client.append_rule({
        rule_any = { name = { "Zoom Cloud Meetings" } },
        except_any = { name = { "Zoom Meeting" } },
        properties = {
            floating = true,
            width = 614,
            height = 410,
            ontop = true,
            placement = awful.placement.centered,
        },
    })
    -------------------------------------------------------
    ----            Start app on workplace             ----
    -------------------------------------------------------
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "firefox",
    --             "Nightly",
    --             "Google-chrome",
    --         },
    --     },
    --     except_any = {
    --         role = { "GtkFileChooserDialog" },
    --         instance = { "Toolkit" },
    --         type = { "dialog" },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[1] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "underlords",
    --             "deadcells",
    --             "csgo_linux64",
    --             "EtG.x86_64",
    --             "factorio",
    --             "dota2",
    --             "Terraria.bin.x86",
    --             "dontstarve_steam",
    --             "Wine",
    --         },
    --         instance = {
    --             "leagueclient.exe",
    --             "glyphclientapp.exe",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[2] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "discord",
    --             "Caprine",
    --             "TelegramDesktop",
    --             "TeamSpeak 3",
    --             "zoom",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[3] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "^editor$",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[4] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "bpytop",
    --             "htop",
    --         },
    --         instance = {
    --             "bpytop",
    --             "htop",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[5] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "Gimp",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[6] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "Steam",
    --             "battle.net.exe",
    --             "Lutris",
    --         },
    --         name = {
    --             "Steam",
    --         },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[8] },
    -- })
    -- --<~>--
    -- ruled.client.append_rule({
    --     rule_any = {
    --         class = {
    --             "qbittorrent",
    --             "VirtualBox Manager",
    --             -- "KeePassXC"
    --         },
    --         instance = {
    --             "qbittorrent",
    --             "qemu",
    --         },
    --     },
    --     except_any = {
    --         type = { "dialog" },
    --     },
    --     properties = { screen = 1, tag = awful.screen.focused().tags[10] },
    -- })
end)
