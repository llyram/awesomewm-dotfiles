local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")

local arch_icon = gears.filesystem.get_configuration_dir() .. "widgets/dock/arch-icon.png"


awesome.register_xproperty("WM_NAME","string")
awesome.register_xproperty("WM_CLASS","string")

local tasklist = awful.widget.tasklist {
    screen   = screen[1],
    filter   = awful.widget.tasklist.filter.allscreen,
    -- buttons  = tasklist_buttons,
    style    = {
        shape = gears.shape.rounded_rect,
        bg_focus = "#ffffff" .. "20",
        bg_normal = gruvbox.bg0 .. "00",
    },
    buttons = {
        awful.button({}, 1, function(c)
            c:activate{context = "tasklist", action = "toggle_minimization", switch_to_tag = true}
            -- c:raise()
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
        layout = wibox.layout.grid.vertical
    },
    widget_template = {
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
        -- create_callback = function(self, c, index, objects)
        --     local tooltip = awful.tooltip({
        --         objects = { self },
        --         timer_function = function()
        --         return c.name
        --         end,
        --     })
            
        --     -- Then you can set tooltip props if required
        --     tooltip.align = "left"
        --     tooltip.mode = "outside"
        --     tooltip.preferred_positions = {"left"}
        -- end,
    },
}

local separator = wibox.widget {
    widget = wibox.widget.separator,
    forced_height = 48,
    orientation = "horizontal",
    forced_width = 20,
}

local app_drawer = wibox.widget{
    {    {
            widget = wibox.widget.imagebox,
            image = arch_icon,
            resize = true,
            forced_width = 40,
            forced_height = 40,
        },
        widget = wibox.container.place,
        halign = "right",
    },
    widget = wibox.container.margin,
    left = 5,
}

app_drawer:connect_signal('button::press',
    function()
        awful.util.spawn("/home/maryll/.config/rofi/bin/launcher_ribbon")
    end
)

dock = awful.popup {
    widget = {
        -- {
        --     app_drawer,
        --     separator,
            tasklist,
        --     layout = wibox.layout.fixed.vertical,
        -- },
        widget = wibox.container.margin,
        margins = 5,
    },
    border_color = '#777777',
    border_width = 1,
    bg = nord.nord0,
    ontop        = true,
    placement    = awful.placement.left,
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
    height = dock.height + dpi(250),
    width = 1,
    bg = "#ffffff00",
    -- below = true,
    ontop = true,
})

awful.placement.left(dock_activator)
dock_activator:connect_signal('mouse::enter', 
    function()
        dock.visible = true
        if popup_timer then
            popup_timer:stop()
            popup_timer = nil
        end
    end
)

dock_activator:connect_signal('mouse::leave',
    function()
        autohide()
    end
)

dock:connect_signal('mouse::enter',
    function()
        if popup_timer then
            popup_timer:stop()
            popup_timer = nil
        end
    end
)

dock:connect_signal('mouse::leave',
    function()
        autohide()
    end
)

-- local dock_tooltip = awful.tooltip{}
-- dock_tooltip:add_to_object(tasklist)
-- tasklist:connect_signal('mouse::enter',
--     function(c)
--         dock_tooltip.text = c.name
--     end
-- )


dock:set_xproperty("WM_NAME", "dock")
dock:set_xproperty("WM_CLASS", "dock")






