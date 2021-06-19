local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

awesome.register_xproperty("WM_NAME","string")

local desktopClock = wibox{
    widget = {
        {
            {
                {
                    {
                        widget = wibox.widget.textclock('<span font="Poppins Bold 70" color="#2e253a">%H:%M </span>', 10)
                    },
                    widget = wibox.container.place,
                    forced_height = 80,
                    -- left = 50,
                    -- top = 50
                },
                widget = wibox.container.background,
                -- bg = "#ffffff"
            },
            {
                {
                    widget = wibox.widget.textclock('<span font="Poppins Bold 20" color="#2e253a">%a, %b %d </span>', 5)
                },
                widget = wibox.container.place,
                valign = "bottom",
            },
            layout = wibox.layout.fixed.vertical,  
        },
        widget = wibox.container.margin,
        top = 100, 
    },
    bg = "#00000000",
    width = 350,
    height = 400,
    visible = true,
    below = true
}

desktopClock:set_xproperty("WM_NAME", "widget")

awful.placement.top(desktopClock)
