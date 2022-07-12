-------------------------------------------------------
--/=================================================\--
--|>              CLIENT KEY BINDINGS              <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local mod = require("main.bindings.mod")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
--<~>--
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -------------------------------------------------------
        ----                 Close client                  ----
        -------------------------------------------------------
        awful.key({ mod.super }, "q", function(c)
            c:kill()
        end, { description = "Close client", group = "client" }),
        -------------------------------------------------------
        ----   Relative move client using arrow/vim keys   ----
        -------------------------------------------------------
        awful.key({ mod.super, mod.shift, mod.ctrl }, "j", function(c)
            c:relative_move(0, dpi(20), 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "k", function(c)
            c:relative_move(0, dpi(-20), 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "h", function(c)
            c:relative_move(dpi(-20), 0, 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "l", function(c)
            c:relative_move(dpi(20), 0, 0, 0)
        end),
        --<~>--
        awful.key({ mod.super, mod.shift, mod.ctrl }, "Down", function(c)
            c:relative_move(0, dpi(20), 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "Up", function(c)
            c:relative_move(0, dpi(-20), 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "Left", function(c)
            c:relative_move(dpi(-20), 0, 0, 0)
        end),
        awful.key({ mod.super, mod.shift, mod.ctrl }, "Right", function(c)
            c:relative_move(dpi(20), 0, 0, 0)
        end),
        -------------------------------------------------------
        ----          Pin ontop/all tags (sticky)          ----
        -------------------------------------------------------
        awful.key({ mod.super, mod.shift }, "p", function(c)
            c.ontop = not c.ontop
        end, { description = "Toggle client on top", group = "client" }),
        -- --<~>--
        awful.key({ mod.super, mod.ctrl }, "p", function(c)
            c.sticky = not c.sticky
        end, { description = "Toggle client sticky", group = "client" }),
        -------------------------------------------------------
        ----                Toggle floating                ----
        -------------------------------------------------------
        awful.key(
            { mod.super, mod.shift },
            "f",
            awful.client.floating.toggle,
            { description = "Toggle floating", group = "client" }
        ),
        -------------------------------------------------------
        ----             Center focused client             ----
        -------------------------------------------------------
        awful.key({ mod.super }, "c", function(c)
            awful.placement.centered(c, {
                honor_workarea = true,
                honor_padding = true,
            })
        end),
        -------------------------------------------------------
        ----               Toggle fullscreen               ----
        -------------------------------------------------------
        awful.key({ mod.super }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "Toggle fullscreen", group = "client" }),
        -------------------------------------------------------
        ----          Toggle [un]-[V|H]maximized           ----
        -------------------------------------------------------
        awful.key({ mod.super }, "m", function(c)
            if c.maximized_horizontal == true and c.maximized_vertical == true then
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical = not c.maximized_vertical
            else
                c.maximized = not c.maximized
            end
            c:raise()
        end, { description = "Toggle (un)maximized", group = "client" }),
        --<~>--
        awful.key({ mod.super, mod.ctrl }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "Toggle (un)V-maximized", group = "client" }),
        --<~>--
        awful.key({ mod.super, mod.shift }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "Toggle (un)H-maximize", group = "client" }),
        -------------------------------------------------------
        ----             Toggle (un)minimized              ----
        -------------------------------------------------------
        awful.key({ mod.super }, "n", function(c)
            c.minimized = true
        end, { description = "Toggle minimize", group = "client" }),
        -------------------------------------------------------
        ----             Change client opacity             ----
        -------------------------------------------------------
        awful.key({ mod.super, mod.ctrl }, "y", function(c)
            c.opacity = c.opacity - 0.1
        end, { description = "Decrease client opacity", group = "client" }),
        awful.key({ mod.super, mod.ctrl }, "o", function(c)
            c.opacity = c.opacity + 0.1
        end, { description = "Increase client opacity", group = "client" }),
        -------------------------------------------------------
        ----       Toggle titlebars for focused/all        ----
        -------------------------------------------------------
        -- awful.key({ mod.super }, "t", function(c)
        --     decorations.cycle(c)
        --     helpers.SoD_tap(nil, function()
        --         local clients = awful.screen.focused().clients
        --         for _, c in pairs(clients) do
        --             decorations.cycle(c)
        --         end
        --     end)
        -- end, { description = "Toggle titlebar for focused/all", group = "client" }),
        -------------------------------------------------------
        ----             Move to master/screen             ----
        -------------------------------------------------------
        awful.key({ mod.super, mod.shift }, "t", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "Move to master", group = "client" }),
        --<~>--
        awful.key({ mod.super, mod.ctrl }, "t", function(c)
            c:move_to_screen()
        end, { description = "Move to screen", group = "client" }),
    })
end)
