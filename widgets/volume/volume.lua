local wibox = require("wibox")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local gfs = require("gears.filesystem")
local dpi = require('beautiful').xresources.apply_dpi
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

local volume_icon = gears.filesystem.get_configuration_dir() .. "/widgets/volume/headphones.svg"
local GET_VOLUME_CMD = 'amixer sget Master'
-- local GET = 


local volume = {
    n = nil,
    level = 0,
    step = 5,
    timeout = 2,
    max = 120,
}

function volume.inc()
    if volume.level < volume.max then
        volume.level = volume.level + volume.step
        spawn.with_shell('pactl -- set-sink-volume @DEFAULT_SINK@ ' .. tostring(volume.level) .. '%')
    end
    volume.notif()

    progress.visible = false
end

function volume.dec()
    if volume.level > 0 then 
        volume.level = volume.level - volume.step
        spawn.with_shell('pactl -- set-sink-volume @DEFAULT_SINK@ ' .. tostring(volume.level) .. '%')
    end
    volume.notif()
end

function volume.toggle()
    spawn.with_shell('amixer -D pulse sset Master toggle')
    volume.notif()
end

function volume.notif()
    if volume.n and not volume.n.is_destroyed and not volume.n.is_expired then
        volume.n.message = tostring(volume.level)
    else
        volume.n = naughty.notification {
            text = tostring(volume.level),
            position = "top_left",
            icon = volume_icon,
            font = "Open Sans Bold 15",
            title = "indicator",
            timeout = volume.timeout,
        }
    end
end

function getVolume()
    spawn.easy_async("/home/maryll/.config/awesome/widgets/volume/getVolume.sh", function(stdout)
        volume.level = tonumber(stdout)
    end)
end

getVolume()



progress = awful.popup{
    widget = {
        {
            {
                {
                    max_value     = 100,
                    value         = volume.level,
                    forced_height = 15,
                    forced_width  = 100,
                    paddings      = 0,
                    border_width  = 1,
                    -- border_color  = "#ffffff",
                    color = "#0076d7",
                    background_color = "#000000",
                    -- bar_shape = gears.shape.rounded_rect,
                    widget        = wibox.widget.progressbar,
                },
                layout = wibox.container.rotate,
                direction = 'east',
            },
            {
                text   = tostring(50),
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.align.vertical
        },
        widget = wibox.container.margin,
        margins = 20,
    },
    ontop = true,
    visible = false
}

awful.placement.top_left(progress, {margins = {top = 40, left = 20}})

return volume