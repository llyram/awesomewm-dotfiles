local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local naughty = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

local brightness = {}
n = nil

local timeout = 1.5
local b
brightness_icon = gears.filesystem.get_configuration_dir() .. "icons/sun.png"

function brightness.inc()
    if b < 100 then
        b = b + 5
        spawn.with_shell("xbacklight -set " .. tostring(b))
    end
    notif()
end

function brightness.dec()
    if b > 0 then
        b = b - 5
        spawn.with_shell("xbacklight -set " .. tostring(b))
    end
    notif()
end

function notif()
    if n and not n.is_destroyed and not n.is_expired then
        n.message = tostring(b)
    else
        n = naughty.notification {
            text = tostring(b),
            position = "top_left",
            timeout = timeout,
            icon = brightness_icon,
            font = "Sans Regular 15",
        }
    end
end

spawn.easy_async("xbacklight", function(stdout)
    b = tonumber(string.match(stdout, "(%d+)%."))
end)

return brightness
