pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local dpi = require("beautiful.xresources").apply_dpi


awesome.register_xproperty("WM_CLASS","string")

-- Mouse and Keybindings
require("keys")
modkey = "Mod4"

-- Initializing modules
require('module.notifications')

-- Initializing widgets
local battery_widget = require("widgets.battery-widget.battery")
local cal = require("widgets.calendar")
local mytextclock = require("widgets.textclock")
local systray = require("widgets.systray")
-- require("widgets.dock.dock")
-- local animationwidget = require("widgets.animationwidget")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- fs define colours, icons, font and wallpapers.
beautiful.init(require("theme.theme"))

-- beautiful.notification_max_width = dpi(400)
-- beautiful.notification_max_height = dpi(150)

-- This is used later as the default terminal and editor to run.
-- require("apps")

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    {
        "hotkeys",
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
    }, {"manual", terminal .. " -e man awesome"},
    {"edit config", "code ~/.config/awesome/"}, {"restart", awesome.restart},
    {"quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
    items = {
        {"awesome", myawesomemenu, beautiful.awesome_icon},
        {"open terminal", terminal}
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile, awful.layout.suit.floating,
        awful.layout.suit.tile.left, awful.layout.suit.max,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        awful.layout.suit.fair, awful.layout.suit.fair.horizontal,
        awful.layout.suit.spiral, awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max.fullscreen, awful.layout.suit.magnifier,
        awful.layout.suit.corner.nw
    })
end)
-- }}}

-- {{{ Wibar

mytextclock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then cal_toggle() end
end)


screen.connect_signal("request::wallpaper", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)


screen.connect_signal("request::desktop_decoration", function(s)
     -- Each screen has its own tag table.
     awful.tag({"  ", "  ", "  ", " 奈 ", "  "}, s, awful.layout.layouts[1])

     -- Create a promptbox for each screen
     s.mypromptbox = awful.widget.prompt()

     -- Create an imagebox widget which will contain an icon indicating which layout we're using.
     -- We need one layoutbox per screen.
     s.mylayoutbox = awful.widget.layoutbox {
         screen = s,
         buttons = {
             awful.button({}, 1, function() awful.layout.inc(1) end),
             awful.button({}, 3, function() awful.layout.inc(-1) end),
             awful.button({}, 4, function() awful.layout.inc(-1) end),
             awful.button({}, 5, function() awful.layout.inc(1) end)
         }
     }

    -- Create a taglist widget
     s.mytaglist = awful.widget.taglist {
        screen = s,
        spacing = 10,
        filter = awful.widget.taglist.filter.all,
        style = {
            bg_focus = beautiful.bg_normal
        },
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({modkey}, 1, function(t)
                if client.focus then client.focus:move_to_tag(t) end
            end), 
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({modkey}, 3, function(t)
                if client.focus then client.focus:toggle_tag(t) end
            end),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                    -- forced_width = 17
                },
                left  = -5,
                right = -5,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
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
            max_widget_size = 250,
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        -- {
                            {
                                {id = 'icon_role', widget = wibox.widget.imagebox},
                                margins = 1,
                                widget = wibox.container.margin
                            },
                            {id = 'text_role', widget = wibox.widget.textbox},
                            layout = wibox.layout.fixed.horizontal,
                            max_widget_size = 200,
                        -- },
                        -- widget = wibox.container.constraint,
                        -- width = 200
                    },
                    widget = wibox.layout.align.vertical

                },
                left = dpi(20),
                right = dpi(20),
                top = dpi(2),
                bottom = dpi(2),
                widget = wibox.container.margin,
            },
            id = 'background_role',
            -- bg = "#ffffff",
            widget = wibox.container.background,
        }
    }


    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s, height = dpi(27)})
    -- s.mywibox:set_xproperty("WM_NAME", "wibar")

    -- Add widgets to the wibox
    s.mywibox.widget = {
        layout = wibox.layout.align.horizontal,
        -- expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(wibox.layout.margin(s.mylayoutbox, dpi(5), 5, 5, 5), nord.nord3),
            s.mytaglist,
            s.mypromptbox,
        },
        {
            nil,
            s.mytasklist,
            nil,
            layout = wibox.layout.align.horizontal,
            expand = "outside",
        },
        -- nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = -16,
            wibox.widget{
                {
                    battery_widget(),
                    widget = wibox.container.margin,
                    left = dpi(10),
                    right = dpi(15),
                },
                widget = wibox.container.background,
                bg = nord.nord1,
                shape = function(cr, width, height)
                    gears.shape.powerline(cr, width, height, -15)
                end,
            },
            systray,
            mytextclock,
            wibox.widget{
                wibox.layout.margin(require('notif-center'), 10, 2, 2, 2),
                widget = wibox.container.background,
                bg = "#6c768a",
                shape = function(cr, width, height)
                    gears.shape.rectangular_tag(cr, width, height, 15)
                end,
            }
            
        }
     }

 end)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients.

ruled.client.connect_signal("request::rules", function()
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id = "titlebars",
        rule_any = {
            type = {
                "Wine", "NetBeans IDE 8.2", "sun-awt-X11-XFramePeer"
            }
        },
        properties = {titlebars_enabled = true}
    }

    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    }

    ruled.client.append_rule {
        id = "Picture in picture",
        rule_any = {
            name = {"Picture-in-picture"}
        },
        properties = {
            ontop = true,
            floating = true,
        }
    }

    ruled.client.append_rule {
        id = "Teamviewer",
        rule_any = {
            class = {"TeamViewer"}
        },
        properties = {
            border_width = 0,
            floating = true,
        }
    }

    ruled.client.append_rule {
        id = "plank",
        rule_any = {
            class = {"Plank"}
        },
        properties = {
            border_width = 0,
            -- ontop = true,
            focusable = false,
            below = false,
            floating = true,
        }
    }


    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {
                "copyq", 
                "pinentry"
            },
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer", "Wine",
                "CPU Simulator"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown thfloatingere might not match defined rules here.
            name = {
                "Event Tester", -- xev.
                -- "Picture in picture"
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        except_any = {
            class = {"crx_peoigcfhkflakdcipcclkneidghaaphd"},
            -- name = {"csTimer - Professional Rubik's Cube Speedsolving/Training Timer"}
        },
        properties = {floating = true}
    }

end)

-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({}, 1, function()
            c:activate{context = "titlebar", action = "mouse_move"}
        end), awful.button({}, 3, function()
            c:activate{context = "titlebar", action = "mouse_resize"}
        end)
    }

    awful.titlebar(c,{font = "Open Sans 7", size = dpi(25)}).widget = {
        { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            -- buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule = {},
        properties = {screen = awful.screen.preferred, implicit_timeout = 5}
    }
end)



-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate{context = "mouse_enter", raise = false}
end)

-- Make the focused window have a glowing border
client.connect_signal('focus', function(c)
    c.border_color = beautiful.border_color_active
end)
client.connect_signal('unfocus', function(c)
    c.border_color = beautiful.border_color_normal
end)

-- Autostart
awful.spawn.with_shell("compton")
awful.util.spawn("nm-applet --indicator")
awful.util.spawn("blueman-applet")
awful.util.spawn("kdeconnect-indicator")
awful.util.spawn("xfce4-power-manager")
awful.util.spawn("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &")
-- awful.util.spawn("redshift-gtk -l 20.5937:78.9629 -t 6500:3400")
