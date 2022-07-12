local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
-- local apps = require("apps")

local helpers = require("helpers")

-- Search
local search_icon = wibox.widget({
    font = "MesloLGS NF",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox(),
})

local reset_search_icon = function()
    search_icon.markup = helpers.colorize_text("Run/Search: ", x.color7) --
end
reset_search_icon()

local search_text = wibox.widget({
    -- markup = helpers.colorize_text("Search", x.color8),
    align = "center",
    valign = "center",
    font = "MesloLGS NF",
    widget = wibox.widget.textbox(),
})

local search_bar = wibox.widget({
    shape = gears.shape.rounded_bar,
    bg = x.color0,
    widget = wibox.container.background(),
})

local search = wibox.widget({
    -- search_bar,
    {
        {
            search_icon,
            {
                search_text,
                bottom = dpi(2),
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(15),
        widget = wibox.container.margin,
    },
    forced_height = dpi(30),
    forced_width = dpi(560),
    shape = gears.shape.rounded_bar,
    bg = x.color0,
    widget = wibox.container.background(),
    -- layout = wibox.layout.stack
})

local function generate_prompt_icon(icon, color)
    return "<span font='MesloLGS NF 10' foreground='" .. color .. "'>" .. icon .. "</span> "
end

function ctrldock_activate_prompt(action)
    ctrldock.visible = true
    search_icon.visible = false
    local prompt
    if action == "run" then
        prompt = generate_prompt_icon(">", x.color2) --
    elseif action == "web_search" then
        prompt = generate_prompt_icon("?", x.color4) --
    end
    helpers.prompt(action, search_text, prompt, function()
        search_icon.visible = true
        if mouse.current_wibox ~= ctrldock then
            ctrldock.visible = false
        end
    end)
end

local prompt_is_active = function()
    -- The search icon is hidden and replaced by other icons
    -- when the prompt is running
    return not search_icon.visible
end

search:buttons(gears.table.join(
    awful.button({}, 1, function()
        ctrldock_activate_prompt("run")
    end),
    awful.button({}, 3, function()
        ctrldock_activate_prompt("web_search")
    end)
))

-- Create the ctrldock
ctrldock = wibox({
    bg = "#00000000",
    fg = "#FFFFFF",
    opacity = 0.5,
    height = dpi(300),
    width = dpi(600),
    x = screen.primary.geometry.height / 2,
    y = 0,
    visible = false,
    ontop = true,
    type = "dock",
    screen = screen.primary,
})

local radius = beautiful.ctrldock_border_radius or 0
if beautiful.ctrldock_position == "bottom" then
    awful.placement.bottom(ctrldock)
else
    awful.placement.bottom(ctrldock)
end
awful.placement.bottom(ctrldock, { honor_workarea = true, margins = { top = beautiful.useless_gap * 2 } })

ctrldock:buttons(gears.table.join(
    -- Middle click - Hide ctrldock
    awful.button({}, 2, function()
        ctrldock_hide()
    end)
))

ctrldock_show = function()
    ctrldock.visible = true
end

ctrldock_hide = function()
    -- Do not hide it if prompt is active
    if not prompt_is_active() then
        ctrldock.visible = false
    end
end

ctrldock_toggle = function()
    if ctrldock.visible then
        ctrldock_hide()
    else
        ctrldock.visible = true
    end
end

-- Hide sidebar when mouse leaves
if user.ctrldock.hide_on_mouse_leave then
    ctrldock:connect_signal("mouse::leave", function()
        ctrldock_hide()
    end)
end

ctrldock:setup({
    {
        {
            -----------  TOP GROUP -----------
            {
                {
                    helpers.vertical_pad(dpi(20)),
                    {
                        nil,
                        search,
                        expand = "none",
                        layout = wibox.layout.align.horizontal,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                left = dpi(20),
                right = dpi(20),
                bottom = dpi(20),
                widget = wibox.container.margin,
            },
            shape = helpers.prrect(dpi(30), true, true, true, true),
            bg = x.color3,
            widget = wibox.container.background,
        },
        layout = wibox.layout.align.vertical,
    },
    shape = helpers.prrect(dpi(30), true, true, false, false),
    bg = x.background,
    widget = wibox.container.background,
})
