local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local gears = require("gears")


mysystray = wibox.widget {
    {
        wibox.widget.systray,
        widget = wibox.container.margin,
        -- margins = dpi(5),
        left = dpi(15),
        top = dpi(5),
        bottom = dpi(5),
        right = dpi(15),
    },
    widget = wibox.container.background,
    bg = nord.nord2,
    shape = function(cr, width, height)
        gears.shape.powerline(cr, width, height, -15)
    end,
}

return mysystray
