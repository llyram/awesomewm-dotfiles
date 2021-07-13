local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")
local clickable_container = require("widgets.clickable-container")


local centered_tasklist = awful.widget.tasklist {
    screen = screen[1],
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = {
        awful.button({}, 1, function(c)
            c:activate{context = "tasklist", action = "toggle_minimization"}
        end), awful.button({}, 3, function()
            awful.menu.client_list {theme = {width = dpi(250)}}
        end),
        awful.button({}, 4, function()
            awful.client.focus.byidx(-1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx(1)
        end)
    },
    style = {
        shape = function(cr, width, height)
            gears.shape.parallelogram(cr, width, height, width-15)
        end,
    },
    layout = {
        spacing = -10,
        layout = wibox.layout.flex.horizontal,
        -- max_widget_size = 250,
    },
    widget_template = {
        {
            {
                {
                    {
                        {
                            {
                                {id = 'icon_role', widget = wibox.widget.imagebox},
                                margins = 1,
                                widget = wibox.container.margin
                            },
                            {
                                id = 'text_role', widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.horizontal,
                            max_widget_size = 200,
                        },
                        widget = wibox.container.constraint,
                        forced_width = 250
                    },
                    widget = wibox.layout.align.vertical
                
                },
                left = dpi(20),
                right = dpi(20),
                top = dpi(2),
                bottom = dpi(2),
                widget = wibox.container.margin,
            },
            widget = clickable_container,
        },
        id = 'background_role',
        -- bg = "#ffffff",
        widget = wibox.container.background,
        
    }
}

return centered_tasklist