local wibox = require("wibox")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local gfs = require("gears.filesystem")
local dpi = require('beautiful').xresources.apply_dpi
local beautiful = require("beautiful")
local gears = require("gears")

local volume_icon = gears.filesystem.get_configuration_dir() .. "/awesome-wm-widgets/volume/headphones.svg"
local GET_VOLUME_CMD = 'amixer sget Master'


local volume = {
    vn = nil,
    level = 0,
}

function volume.inc()
    if volume.level < 100 then
        volume.level = volume.level + 5
        spawn.with_shell('amixer -D pulse sset Master ' .. tostring(volume.level) .. '%')
    end
    volume.notif()
end

function volume.dec()
    if volume.level > 0 then 
        volume.level = volume.level - 5
        spawn.with_shell('amixer -D pulse sset Master ' .. tostring(volume.level) .. '%')
    end
    volume.notif()
end

function volume.toggle()
    spawn.with_shell('amixer -D pulse sset Master toggle')
    volume.notif()
end

function volume.notif()
    if volume.vn and not volume.vn.is_destroyed and not volume.vn.is_expired then
        volume.vn.message = tostring(volume.level)
    else
        volume.vn = naughty.notification {
            text = tostring(volume.level),
            position = "top_left",
            icon = volume_icon,
            font = "Sans Regular 15",
            title = "indicator"
        }
    end
end

local function parse_output(stdout)
    local level = string.match(stdout, "(%d?%d?%d)%%")
    volume.level = tonumber(string.format("% 3d", level))

    return level
end

spawn.easy_async(GET_VOLUME_CMD, function(stdout)
    -- local level = string.match(stdout, "(%d?%d?%d)%%")
    volume.level = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
    
end)

return volume