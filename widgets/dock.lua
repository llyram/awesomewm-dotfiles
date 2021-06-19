local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")


awesome.register_xproperty("WM_NAME","string")

local tasklist = awful.widget.tasklist {
    screen   = screen[1],
    filter   = awful.widget.tasklist.filter.allscreen,
    -- buttons  = tasklist_buttons,
    style    = {
        shape = gears.shape.rounded_rect,
        bg_focus = gruvbox.blue .. "50",
        bg_normal = gruvbox.bg0 .. "00",
    },
    buttons = {
        awful.button({}, 1, function(c)
            c:activate{context = "tasklist", action = "toggle_minimization"}
            
        end), 
        awful.button({}, 3, function()
            awful.menu.client_list {theme = {width = dpi(250)}}
        end),
        awful.button({}, 4, function()
            awful.client.focus.byidx(-1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx(1)
        end)
    },
    layout   = {
        spacing = 5,
        -- forced_num_rows = 1,
        layout = wibox.layout.grid.horizontal
    },
    widget_template = {
        {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 4,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 48,
            forced_height   = 48,
            widget          = wibox.container.background,
            -- bg = "#ffffff00",
            create_callback = function(self, c, index, objects) --luacheck: no unused
                self:get_children_by_id('clienticon')[1].client = c
            end,
        },
        layout = wibox.layout.flex.vertical
    },
}

dock = awful.popup {
    widget = tasklist,
    -- border_color = '#777777',
    -- border_width = 2,
    bg = "#ffffff00",
    ontop        = true,
    placement    = awful.placement.bottom,
    visible = false,
}

local popup_timer
    local autohide = function ()
        if popup_timer then
            popup_timer:stop()
            popup_timer = nil
        end
        popup_timer = gears.timer.start_new(0.5, function()
            popup_timer = nil
            dock.visible = false
        end)
    end

local dock_activator = wibox({
    visible = true,
    width = dock.width + dpi(250),
    height = 1,
    bg = "#ffffff",
    -- below = true,
    ontop = true,
})
awful.placement.bottom(dock_activator)
dock_activator:connect_signal(
    'mouse::enter', 
    function()
        dock.visible = true
        if popup_timer then
            popup_timer:stop()
            popup_timer = nil
        end
    end
)

dock_activator:connect_signal(
    'mouse::enter', 
    function()
        if popup_timer then
            popup_timer:stop()
            popup_timer = nil
        end
    end
)

dock_activator:connect_signal(
    'mouse::leave',
    function()
        autohide()
    end
)
dock:connect_signal(
    'mouse::leave',
    function()
        autohide()
    end
)



dock:set_xproperty("WM_NAME", "dock")






