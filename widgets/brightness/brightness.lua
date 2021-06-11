local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

local brightness = {
    n = nil,
    level = 0,
    step = 5,
    timeout = 2,
}

brightness_icon = gears.filesystem.get_configuration_dir() .. "widgets/brightness/sun.png"

function brightness.inc()
    if brightness.level < 100 then
        brightness.level = brightness.level + brightness.step
        spawn.with_shell("xbacklight -set " .. tostring(brightness.level))
    end
    notif()
end

function brightness.dec()
    if brightness.level > 0 then
        brightness.level = brightness.level - brightness.step
        spawn.with_shell("xbacklight -set " .. tostring(brightness.level))
    end
    notif()
end

function notif()
    if brightness.n and not brightness.n.is_destroyed and not brightness.n.is_expired then
        brightness.n.message = tostring(brightness.level)
    else
        brightness.n = naughty.notification {
            text = tostring(brightness.level),
            position = "top_left",
            timeout = brightness.timeout,
            icon = brightness_icon,
            font = "Open Sans Bold 15",
            title = "indicator",
        }
    end
end

spawn.easy_async("xbacklight", function(stdout)
    brightness.level = tonumber(string.match(stdout, "(%d+)%."))
end)


return brightness
