local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local helpers = {}

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

helpers.squircle = function(rate, delta)
    return function(cr, width, height)
        gears.shape.squircle(cr, width, height, rate, delta)
    end
end
helpers.psquircle = function(rate, delta, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partial_squircle(cr, width, height, tl, tr, br, bl, rate, delta)
    end
end

-- Padding
function helpers.vertical_pad(height)
    return wibox.widget({
        forced_height = height,
        layout = wibox.layout.fixed.vertical,
    })
end

function helpers.horizontal_pad(width)
    return wibox.widget({
        forced_width = width,
        layout = wibox.layout.fixed.horizontal,
    })
end

helpers.colorize_text = function(text, color)
    return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

local double_tap_timer = nil
function helpers.single_double_tap(single_tap_function, double_tap_function)
    if double_tap_timer then
        double_tap_timer:stop()
        double_tap_timer = nil
        -- double_tap_function()
        -- naughty.notify({ text = "We got a double tap" })
        return
    end

    double_tap_timer = gears.timer.start_new(0.20, function()
        double_tap_timer = nil
        -- naughty.notify({ text = "We got a single tap" })
        if single_tap_function then
            single_tap_function()
        end
        return false
    end)
end

function helpers.volumectl(value)
    local cmd
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

function helpers.brightctl(value)
    local cmd
    if value == 0 then
        cmd = "xbacklight -set 10"
    -- elseif value == 1 then
    --     cmd = "xbacklight -set 100"
    else
        sign = value > 0 and "+" or ""
        cmd = "xbacklight " .. sign .. tostring(value)
    end
    awful.spawn.with_shell(cmd)
end

-- Resize
-- Constants --
local f_resize_value = dpi(20)
local t_resize_factor = 0.05
---------------
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
--<~>--
local direction_translate = {
    ["up"] = "top",
    ["down"] = "bottom",
    ["left"] = "left",
    ["right"] = "right",
}
function helpers.move_to_edge(c, direction)
    local old = c:geometry()
    local new = awful.placement[direction_translate[direction]](c, {
        honor_padding = true,
        honor_workarea = true,
        margins = beautiful.useless_gap * 2,
        pretend = true,
    })
    if direction == "up" or direction == "down" then
        c:geometry({ x = old.x, y = new.y })
    else
        c:geometry({ x = new.x, y = old.y })
    end
end
-- Move client DWIM (Do What I Mean)
-- Move to edge if the client / layout is floating
-- Swap by index if maximized
-- Else swap client by direction
function helpers.mover(c, direction)
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        helpers.move_to_edge(c, direction)
    elseif awful.layout.get(mouse.screen) ~= awful.layout.suit.max then
        awful.client.swap.bydirection(direction, c, nil)
    end
end
function helpers.float_and_resize(c, width, height)
    c.maximized = false
    c.width = width
    c.height = height
    awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
    awful.client.property.set(c, "floating_geometry", c:geometry())
    c.floating = true
    c:raise()
end

local prompt_font = beautiful.prompt_font or "sans 10"
function helpers.prompt(action, textbox, prompt, callback)
    if action == "run" then
        awful.prompt.run({
            prompt = prompt,
            -- prompt       = "<b>Run: </b>",
            textbox = textbox,
            font = prompt_font,
            done_callback = callback,
            exe_callback = awful.spawn,
            completion_callback = awful.completion.shell,
            history_path = awful.util.get_cache_dir() .. "/history",
        })
    elseif action == "web_search" then
        awful.prompt.run({
            prompt = prompt,
            -- prompt       = '<b>Web search: </b>',
            textbox = textbox,
            font = prompt_font,
            history_path = awful.util.get_cache_dir() .. "/history_web",
            done_callback = callback,
            exe_callback = function(input)
                if not input or #input == 0 then
                    return
                end
                awful.spawn.with_shell(user.web_search_cmd .. "'" .. input .. "'")
                naughty.notify({
                    title = "Searching for",
                    text = input,
                    -- icon = icons.image.firefox,
                    urgency = "low",
                })
            end,
        })
    end
end

-- Screenshots
local capture_notif = nil
local screenshot_app_name = "screenshot"
function helpers.screenshot(action, delay)
    -- Read-only actions
    if action == "browse" then
        awful.spawn.with_shell("cd " .. user.dirs.screenshots .. " && sxiv $(ls -t)")
        return
    elseif action == "gimp" then
        awful.spawn.with_shell("cd " .. user.dirs.screenshots .. " && gimp $(ls -t | head -n1)")
        naughty.notification({
            message = "Opening last screenshot with GIMP",
            icon = icon,
            app_name = screenshot_app_name,
        })
        return
    end

    -- Screenshot capturing actions
    local cmd
    local timestamp = os.date("%Y.%m.%d-%H.%M.%S")
    local filename = user.dirs.screenshots .. "/" .. timestamp .. ".screenshot.png"
    local maim_args = "-u -b 3 -m 5"
    -- local icon = icons.image.screenshot

    local prefix
    if delay then
        prefix = "sleep " .. tostring(delay) .. " && "
    else
        prefix = ""
    end

    -- Configure action buttons for the notification
    local screenshot_open = naughty.action({ name = "Open" })
    local screenshot_copy = naughty.action({ name = "Copy" })
    local screenshot_edit = naughty.action({ name = "Edit" })
    local screenshot_delete = naughty.action({ name = "Delete" })
    screenshot_open:connect_signal("invoked", function()
        awful.spawn.with_shell("cd " .. user.dirs.screenshots .. " && sxiv $(ls -t)")
    end)
    screenshot_copy:connect_signal("invoked", function()
        awful.spawn.with_shell("xclip -selection clipboard -t image/png " .. filename .. " &>/dev/null")
    end)
    screenshot_edit:connect_signal("invoked", function()
        awful.spawn.with_shell("gimp " .. filename .. " >/dev/null")
    end)
    screenshot_delete:connect_signal("invoked", function()
        awful.spawn.with_shell("rm " .. filename)
    end)

    if action == "full" then
        cmd = prefix .. "maim " .. maim_args .. " " .. filename
        awful.spawn.easy_async_with_shell(cmd, function()
            naughty.notification({
                title = "Screenshot",
                message = "Screenshot taken",
                -- icon = icon,
                actions = { screenshot_open, screenshot_copy, screenshot_edit, screenshot_delete },
                app_name = screenshot_app_name,
            })
        end)
    elseif action == "selection" then
        cmd = "maim " .. maim_args .. " -s " .. filename
        capture_notif = naughty.notification({
            title = "Screenshot",
            message = "Select area to capture.",
            -- icon = icon,
            timeout = 1,
            app_name = screenshot_notification_app_name,
        })
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, exit_code)
            naughty.destroy(capture_notif)
            if exit_code == 0 then
                naughty.notification({
                    title = "Screenshot",
                    message = "Selection captured",
                    -- icon = icon,
                    actions = { screenshot_open, screenshot_copy, screenshot_edit, screenshot_delete },
                    app_name = screenshot_app_name,
                })
            end
        end)
    elseif action == "clipboard" then
        capture_notif = naughty.notification({
            title = "Screenshot",
            message = "Select area to copy to clipboard",
            -- icon = icon
        })
        cmd = "maim "
            .. maim_args
            .. " -s /tmp/maim_clipboard && xclip -selection clipboard -t image/png /tmp/maim_clipboard &>/dev/null && rm /tmp/maim_clipboard"
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, exit_code)
            if exit_code == 0 then
                -- capture_notif =
                --     notifications.notify_dwim(
                --     {
                --         title = "Screenshot",
                --         message = "Copied selection to clipboard",
                --         -- icon = icon,
                --         app_name = screenshot_app_name
                --     },
                --     capture_notif
                -- )
                naughty.destroy(capture_notif)
                naughty.notification({
                    title = "Screenshot",
                    message = "Selection captured to clipboard",
                    -- icon = icon,
                    -- actions = {screenshot_open, screenshot_copy, screenshot_edit, screenshot_delete},
                    app_name = screenshot_app_name,
                })
            else
                naughty.destroy(capture_notif)
            end
        end)
    end
end
--<~>--
function helpers.RoS(app, rules, matcher, unique_id, callback)
    awful.spawn.raise_or_spawn(app, rules, function(c)
        if (c.class:lower() or c.instance:lower()) == app then
            c:jump_to()
            return true
        else
            return false
        end
    end, unique_id, callback)
end

return helpers
