-- This uses UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
-- Provides:
-- signal::battery
--      percentage
--      state
local upower_widget = require("module.battery_widget")
local battery_listener = upower_widget {
    device_path = '/sys/class/power_supply/BAT1/capacity',
    instant_update = true,
    use_display_device = true
}

battery_listener:connect_signal("upower::update", function(_, device)
    awesome.emit_signal("signal::battery", device.percentage, device.state)
end)
