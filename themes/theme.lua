-------------------------------------------------------
--/=================================================\--
--|>                    THEMES                     <|--
--\=================================================/--
-------------------------------------------------------
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local x = require("themes.colors")
--<~>--
return {
    font = "Iosevka NF 11",
    title_font = "Iosevka NF 14",
    sub_title_font = "Iosevka NF 9",
    context_font = "Iosevka NF 11",
    --<~>--
    corner_radius = dpi(20),
    border_width = dpi(1),
    useless_gap = 5,
    --<~>--
    bg_normal = x.bg,
    bg_focus = x.cur,
    bg_urgent = x.c0,
    fg_normal = x.fg,
    fg_focus = x.fg_2,
    fg_urgent = x.fg,
    --<~>--
    border_normal = x.bg,
    border_focus = x.c4,
    titlebars_enabled = false,
    -- wallpaper = "~/.dots/home/.config/awesome/themes/bg.jpg",
}