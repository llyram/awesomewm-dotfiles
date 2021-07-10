-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

apps = require("apps")

-- Initialize widgets
require("widgets.exit-screen.exit-screen")
local volume = require("widgets.volume.volume")


-- require("widgets.brightness")

local brightness = require("widgets.brightness.brightness")

superkey = "Mod4"
altkey = "Mod1"

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function() mymainmenu:toggle() end),
    -- awful.button({}, 4, awful.tag.viewprev),
    -- awful.button({}, 5, awful.tag.viewnext)
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings(
    {
        awful.key({ altkey }, "F4", 
            function() 
                exit_screen_show() 
            end, 
            {description = "Show logout screen", group = "custom"}),
        awful.key({superkey}, "o",  
            function() 
                _G.screen.primary.right_panel:toggle() 
            end, 
            {description = 'toggle notification center',group = 'Awesome'}), 
        -- keyboard volume keys
        awful.key({}, 'XF86AudioRaiseVolume', 
            function() 
                volume.inc() 
            end, 
            {description = 'volume up', group = 'hotkeys'}),
        awful.key({}, 'XF86AudioLowerVolume', 
            function() 
                volume.dec() 
            end, 
            {description = 'volume down', group = 'hotkeys'}),
        awful.key({}, 'XF86AudioMute', 
            function() 
                volume.toggle() 
            end, 
            {description = 'toggle mute', group = 'hotkeys'}),
        -- brightness keys
        awful.key({}, "XF86MonBrightnessUp", 
            function() 
                brightness.inc() 
            end,
            {description = "increase brightness", group = "custom"}),
        awful.key({}, "XF86MonBrightnessDown", 
            function()
                brightness.dec() 
            end, 
            {description = "decrease brightness", group = "custom"}),
        -- brightness keys end
        -- Media Keys
        awful.key({}, "XF86AudioPlay", function()
            awful.util.spawn("playerctl play-pause", false)
        end),
        awful.key({}, "XF86AudioNext", function()
            awful.util.spawn("playerctl next", false)
        end),
        awful.key({}, "XF86AudioPrev", function()
            awful.util.spawn("playerctl previous", false)
        end),
        awful.key({superkey}, "s", 
            hotkeys_popup.show_help,
            {description = "show help", group = "awesome"}),
        -- awful.key({superkey,}, "w", 
        --     function(c) 
        --         -- mymainmenu:show() 
        --         c.maximized = not c.maximized
        --     end,
        --     {description = "show main menu", group = "awesome"}),
        awful.key({superkey, "Control"}, "r", 
            awesome.restart,
            {description = "reload awesome", group = "awesome"}),
        awful.key({superkey, "Shift"}, "q", 
            awesome.quit,
            {description = "quit awesome", group = "awesome"}),
        awful.key({superkey}, "x", 
            function()
                awful.prompt.run {
                    prompt = "Run Lua code: ",
                    textbox = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
            end, 
            {description = "lua execute prompt", group = "awesome"}),
        awful.key({superkey}, "Return", 
            function() 
                awful.spawn(terminal) 
            end,
            {description = "open a terminal", group = "launcher"}),
        awful.key({superkey}, "f", 
            function() 
                awful.spawn.with_shell("nautilus") 
            end,
            {description = "open file manager", group = "launcher"}),
        awful.key({superkey}, "r", 
            function()
                awful.util.spawn("/home/maryll/.config/rofi/bin/launcher_ribbon")
            end, 
            {description = "rofi run prompt", group = "launcher"}),
        awful.key({superkey},"p", 
            function() 
                menubar.show() 
            end,
            {description = "show the menubar", group = "launcher"}),
        awful.key({superkey}, "b", 
            function() 
                awful.spawn(browser) 
            end,
            {description = "open a browser", group = "launcher"}),
        awful.key({superkey}, "c",
            function()
                awful.spawn("/usr/lib/brave/brave --profile-directory=Default --app-id=peoigcfhkflakdcipcclkneidghaaphd", {tiled = true})
            end,
            {description = "open csTimer", group = "launcher"})
    })

-- Tags related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key({superkey}, "Left", 
            awful.tag.viewprev,
            {description = "view previous", group = "tag"}),
        awful.key({superkey}, "Right", 
            awful.tag.viewnext,
            {description = "view next", group = "tag"}),
        awful.key({superkey}, "Escape", 
            awful.tag.history.restore,
            {description = "go back", group = "tag"})
    })

-- Focus related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key({superkey}, "j", 
            function() 
                awful.client.focus.byidx(1) 
            end,
            {description = "focus next by index", group = "client"}),
        awful.key({superkey}, "k", 
            function()
                awful.client.focus.byidx(-1)
            end, 
            {description = "focus previous by index", group = "client"}),
        awful.key({superkey, "Control"}, "j",
            function() 
                awful.screen.focus_relative(1) 
            end,
            {description = "focus the next screen", group = "screen"}),
        awful.key({superkey, "Control"}, "k",
            function() 
                awful.screen.focus_relative(-1) 
            end,
            {description = "focus the previous screen", group = "screen"}),
        awful.key({superkey, "Control"}, "n", 
            function()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:activate{raise = true, context = "key.unminimize"}
                end
            end, 
            {description = "restore minimized", group = "client"})
    })

-- Layout related keybindings
awful.keyboard.append_global_keybindings(
    {
        awful.key({superkey, "Shift"}, "j",
            function() 
                awful.client.swap.byidx(1) 
            end, 
            {description = "swap with next client by index", group = "client"}), 
        awful.key({superkey, "Shift"}, "k",
            function() 
                awful.client.swap.byidx(-1) 
            end, 
            {description = "swap with previous client by index",group = "client"}), 
        awful.key({superkey}, "u", 
            awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
        awful.key({superkey}, "l", 
            function() 
                awful.tag.incmwfact(0.05) 
            end, 
            {description = "increase master width factor",group = "layout"}),
        awful.key({superkey}, "h", 
            function() 
                awful.tag.incmwfact(-0.05) 
            end, 
            {description = "decrease master width factor",group = "layout"}), 
        awful.key({superkey, "Shift"}, "h",
            function() 
                awful.tag.incnmaster(1, nil, true) 
            end, 
            {description = "increase the number of master clients",group = "layout"}), 
        awful.key({superkey, "Shift"}, "l",
            function() 
                awful.tag.incnmaster(-1, nil, true) 
            end, 
            {description = "decrease the number of master clients",group = "layout"}), 
        awful.key({superkey, "Control"}, "h",
            function() 
                awful.tag.incncol(1, nil, true) 
            end, 
            {description = "increase the number of columns",group = "layout"}), 
        awful.key({superkey, "Control"}, "l",
            function() 
                awful.tag.incncol(-1, nil, true) 
            end, 
            {description = "decrease the number of columns",group = "layout"}), 
        awful.key({superkey}, "space", 
            function() 
                awful.layout.inc(1) 
            end,
            {description = "select next", group = "layout"}),
        awful.key({superkey, "Shift"}, "space",
            function() 
                awful.layout.inc(-1) 
            end,
            {description = "select previous", group = "layout"})
    })

awful.keyboard.append_global_keybindings(
    {
        awful.key {
            modifiers = {superkey},
            keygroup = "numrow",
            description = "only view tag",
            group = "tag",
            on_press = function(index)
                local screen = awful.screen.focused()
                local tag = screen.tags[index]
                if tag then tag:view_only() end
            end
        }, awful.key {
            modifiers = {superkey, "Control"},
            keygroup = "numrow",
            description = "toggle tag",
            group = "tag",
            on_press = function(index)
                local screen = awful.screen.focused()
                local tag = screen.tags[index]
                if tag then awful.tag.viewtoggle(tag) end
            end
        }, awful.key {
            modifiers = {superkey, "Shift"},
            keygroup = "numrow",
            description = "move focused client to tag",
            group = "tag",
            on_press = function(index)
                if client.focus then
                    local tag = client.focus.screen.tags[index]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end
        }, awful.key {
            modifiers = {superkey, "Control", "Shift"},
            keygroup = "numrow",
            description = "toggle focused client on tag",
            group = "tag",
            on_press = function(index)
                if client.focus then
                    local tag = client.focus.screen.tags[index]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end
        }, awful.key {
            modifiers = {superkey},
            keygroup = "numpad",
            description = "select layout directly",
            group = "layout",
            on_press = function(index)
                local t = awful.screen.focused().selected_tag
                if t then t.layout = t.layouts[index] or t.layout end
            end
        }
    })

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings(
        {
            awful.button({}, 1,
                         function(c)
                c:activate{context = "mouse_click"}
            end), awful.button({superkey}, 1, function(c)
                c:activate{context = "mouse_click", action = "mouse_move"}
            end), awful.button({superkey}, 3, function(c)
                c:activate{context = "mouse_click", action = "mouse_resize"}
            end)
        })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings(
        {
            -- awful.key({superkey,}, "w", 
            -- function(c) 
            --     -- mymainmenu:show() 
            --     c.fullscreen = not c.fullscreen
            --     c:raise()
            -- end,
            -- {description = "show main menu", group = "awesome"}),
            awful.key({superkey, "Shift"}, "f", function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end, {description = "toggle fullscreen", group = "client"}),
            awful.key({superkey}, "q", function(c) c:kill() end,
                      {description = "close", group = "client"}),
            awful.key({superkey, "Control"}, "space", function(c)
                awful.client.floating.toggle(c)
                -- c.ontop = not c.ontop
            end, {description = "toggle floating", group = "client"}),
            awful.key({superkey, "Shift"}, "t", awful.titlebar.toggle),
            awful.key({superkey, "Control"}, "Return",
                      function(c) c:swap(awful.client.getmaster()) end,
                      {description = "move to master", group = "client"}),
            -- awful.key({superkey}, "o", function(c) c:move_to_screen() end,
            --           {description = "move to screen", group = "client"}),
            awful.key({superkey}, "t", function(c)
                c.ontop = not c.ontop
            end, {description = "toggle keep on top", group = "client"}),
            awful.key({superkey}, "n", function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end, {description = "minimize", group = "client"}),
            awful.key({superkey}, "m", function(c)
                c.maximized = not c.maximized
                c:raise()
            end, {description = "(un)maximize", group = "client"}),
            awful.key({superkey, "Control"}, "m", function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end, {description = "(un)maximize vertically", group = "client"}),
            awful.key({superkey, "Shift"}, "m", function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end, {description = "(un)maximize horizontally", group = "client"})
        })
end)

-- }}}

