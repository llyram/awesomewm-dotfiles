local naughty = require('naughty')
local beautiful = require('beautiful')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local wibox = require('wibox')

-- Naughty presets
naughty.config.padding = 100
naughty.config.spacing = 100

naughty.config.defaults.timeout = 3
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'bottom_right'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
-- naughty.config.defaults.font = 'Sans Regular 9'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
-- naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.border_width = dpi(0)
-- naughty.config.defaults.border_color = '#bd93f9'
naughty.config.defaults.bg_color = "#00000000"

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




naughty.connect_signal("request::display", function(n)

    local actions = wibox.widget {
        notification = n,
        base_layout = wibox.widget {
            spacing = dpi(3),
            layout = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        -- font = beautiful.font .. "6",
                        widget = wibox.widget.textbox
                    },
                    left = dpi(6),
                    right = dpi(6),
                    widget = wibox.container.margin
                },
                widget = wibox.container.place
            },
            bg = "#000000",
            forced_height = dpi(25),
            forced_width = dpi(50),
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
        },
        style = {
            underline_normal = false,
            underline_selected = true
        },
        widget = naughty.list.actions
    }
    
    if n.title == "indicator" then
        naughty.layout.box {
            notification = n,
            type = "notification",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 10)
            end,
            widget_template = {
                {
                    ----- Icon -----
                    -- naughty.widget.icon,
                    { ----- Icon -----
                        {
                            {
                                {
                                    -- forced_width = icon_size,
                                    -- forced_height = icon_size,
                                    resize = true,
        
                                    widget = naughty.widget.icon
                                },
                                widget = wibox.container.constraint,
                                width = dpi(30),
                                height = dpi(30),
                            },
                            margins = dpi(10),
                            widget = wibox.container.margin
                        },
                        bg = dracula.current_line,
                        widget = wibox.widget.background
        
                    },
                    {
                        {
                            { ----- Body/Message -----
                                
                                widget = naughty.widget.message,
                                align = "left",
        
                            },
                            top = dpi(15),
                            bottom = dpi(15),
                            left = dpi(10),
                            right = dpi(10),
                            widget = wibox.container.margin,
                            -- color = "#ffffff"
                        },
                        widget = wibox.container.background,
                        bg = dracula.background,
                    },
                    layout = wibox.layout.align.horizontal
                },
        
                strategy = "max",
                height = dpi(180),
                width = dpi(400),
                widget = wibox.container.constraint
            },
        }
    else 
        naughty.layout.box {
            notification = n,
            type = "notification",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 3)
            end,
            widget_template = {
                {
                    ----- Icon -----
                    -- naughty.widget.icon,
                    { ----- Icon -----
                        {
                            {
                                {
                                    -- forced_width = icon_size,
                                    -- forced_height = icon_size,
                                    resize = true,
        
                                    widget = naughty.widget.icon
                                },
                                widget = wibox.container.constraint,
                                width = dpi(48),
                                height = dpi(48),
                            },
                            margins = dpi(10),
                            widget = wibox.container.margin
                        },
                        -- bg = "#282828",
                        widget = wibox.widget.background
        
                    },
                    {
                        {
                            { ---- Title -----
                                -- naughty.widget.title,
                                text = n.title,
                                align = "center",
                                font = "Bangers",
                                widget = wibox.widget.textbox
                            },
        
                            { ----- Body/Message -----
                                
                                widget = naughty.widget.message,
                                align = "left",
        
                                -- font = "Poppins 15",
                                -- text = n.message,
        
                                -- widget = wibox.widget.textbox
        
                            },
                            actions,
                            layout = wibox.layout.align.vertical
                            -- expand = "none"
        
                        },
        
                        margins = dpi(10),
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.align.horizontal
                },
        
                strategy = "max",
                height = dpi(180),
                -- forced_height = 100,
                width = dpi(400),
                -- forced_width = 400,
                widget = wibox.container.constraint
            },
        }
    end
    
end)


