local naughty = require('naughty')
local beautiful = require('beautiful')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

-- Naughty presets
naughty.config.padding = 20
naughty.config.spacing = 20

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'bottom_right'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Sans Regular 9'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
-- naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.border_width = dpi(1)
-- naughty.config.defaults.border_color = '#bd93f9'
naughty.config.defaults.bg_color = "#000000"

-- Error handling
if _G.awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = _G.awesome.startup_errors
    })
end

do
    local in_error = false
    _G.awesome.connect_signal('debug::error', function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = 'You Fucked UP!',
            text = tostring(err)
        })
        in_error = false
    end)
end

function log_this(title, txt)
    naughty.notify({title = 'log: ' .. title, text = txt})
end
