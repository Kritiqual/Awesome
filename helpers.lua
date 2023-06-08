-------------------------------------------------------
--/=================================================\--
--|>                    HELPERS                    <|--
--\=================================================/--
-------------------------------------------------------
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = beautiful.xresources
local dpi = xresources.apply_dpi
--<~>--
local helpers = {}
--<~>--
local direction_translate = {
    ["up"] = "top",
    ["down"] = "bottom",
    ["left"] = "left",
    ["right"] = "right",
}
-------------------------------------------------------
----               Single/double tap               ----
-------------------------------------------------------
local tap_timer = nil
function helpers.SoD_tap(fnSingle, fnDouble)
    if tap_timer then
        tap_timer:stop()
        tap_timer = nil
        fnDouble()
        -- naughty.notify({text = "We got a double tap"})
        return
    end

    tap_timer = gears.timer.start_new(0.2, function()
        tap_timer = nil
        -- naughty.notify({text = "We got a single tap"})
        if fnSingle then
            fnSingle()
        end
        return false
    end)
end
-------------------------------------------------------
-------------------------------------------------------
----                  Controllers                  ----
-------------------------------------------------------
function helpers.volumectl(value)
    local cmd, sign
    if value == 0 then
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    else
        sign = value > 0 and "+" or ""
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "
            .. sign
            .. tostring(value)
            .. "%"
    end
    awful.spawn.with_shell(cmd)
end
--<~>--
function helpers.mediactl(value)
    awful.spawn.with_shell("playerctl " .. value)
end
--<~>--
function helpers.brightctl(value)
    local cmd, sign
    if value == 0 then
        cmd = "xbacklight -set 20"
    elseif value == 1 then
        cmd = "xbacklight -set 100"
    else
        sign = value > 0 and "+" or ""
        cmd = "xbacklight " .. sign .. tostring(value)
    end
    awful.spawn.with_shell(cmd)
end
-------------------------------------------------------
-------------------------------------------------------
----                    Resizer                    ----
-------------------------------------------------------
local f_resize_value = dpi(20)
local t_resize_factor = 0.05
--<~>--
function helpers.resizer(c, direction)
    if c and c.floating then
        if direction == "up" then
            c:relative_move(0, 0, 0, -f_resize_value)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, f_resize_value)
        elseif direction == "left" then
            c:relative_move(0, 0, -f_resize_value, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, f_resize_value, 0)
        end
    elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.floating then
        if direction == "up" then
            awful.client.incwfact(-t_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(t_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-t_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(t_resize_factor)
        end
    end
end
-------------------------------------------------------
-------------------------------------------------------
----                     Mover                     ----
-------------------------------------------------------
function helpers.swapper(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        helpers.move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.max then
        awful.client.swap.bydirection(direction, c, nil)
    end
end
-------------------------------------------------------
-------------------------------------------------------
----                Raise or spawn                 ----
-------------------------------------------------------
function helpers.RoS(app, rules, unique_id, callback)
    awful.spawn.raise_or_spawn(app, rules, function(c)
        if string.find((c.class:lower() or c.instance:lower()), app) then
            c:move_to_tag(awful.screen.focused().selected_tag)
            c:jump_to()
            return true
        else
            return false
        end
    end, unique_id, callback)
end
return helpers
