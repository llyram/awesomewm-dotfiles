local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
-- local notification = require("naughty.notification")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local gears = require("gears")
require("theme.colors")
local xrdb = xresources.get_current_theme()

local theme = {}
-- Load ~/.Xresources colors and set fallback colors
--
theme.darker_bg = "#10171e"
theme.lighter_bg = "#1f272e"
theme.xbackground = xrdb.background or "#131a21"
theme.xforeground = xrdb.foreground or "#ffffff"
theme.xcolor0 = xrdb.color0 or "#29343d"
theme.xcolor1 = xrdb.color1 or "#f9929b"
theme.xcolor2 = xrdb.color2 or "#7ed491"
theme.xcolor3 = xrdb.color3 or "#fbdf90"
theme.xcolor4 = xrdb.color4 or "#a3b8ef"
theme.xcolor5 = xrdb.color5 or "#ccaced"
theme.xcolor6 = xrdb.color6 or "#9ce5c0"
theme.xcolor7 = xrdb.color7 or "#ffffff"
theme.xcolor8 = xrdb.color8 or "#3b4b58"
theme.xcolor9 = xrdb.color9 or "#fca2aa"
theme.xcolor10 = xrdb.color10 or "#a5d4af"
theme.xcolor11 = xrdb.color11 or "#fbeab9"
theme.xcolor12 = xrdb.color12 or "#bac8ef"
theme.xcolor13 = xrdb.color13 or "#d7c1ed"
theme.xcolor14 = xrdb.color14 or "#c7e5d6"
theme.xcolor15 = xrdb.color15 or "#eaeaea"

-- fonts
theme.font = "Product Sans Regular"
theme.taglist_font = "MesloLGS NF"

-- background
theme.bg_normal = "#1e1f29"
-- theme.bg_normal = "#000000"
-- theme.bg_focus = dracula.current_line
theme.bg_focus = "#44475a90"
-- theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal

-- foreground
theme.fg_normal = "#f8f8f2"
theme.fg_focus = nord.nord4
theme.fg_urgent = nord.nord11
theme.fg_minimize = theme.fg_normal

-- titlebar
theme.titlebar_bg_focus = theme.bg_normal
theme.titlebar_bg_normal = nord.nord1
theme.titlebar_fg_normal = theme.fg_normal .. "50"
theme.titlebar_fg_focus = theme.fg_normal

-- systray
theme.systray_icon_spacing = dpi(2)
-- theme.bg_systray = nord.nord2

-- gaps
theme.useless_gap = dpi(5)
theme.gap_single_client = true

-- borders
theme.border_width = dpi(0)
theme.border_color_normal = "#000000"
theme.border_color_active = dracula.comment
theme.border_color_marked = gruvbox.red
theme.maximized_hide_border = true
theme.border_single_client = false

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- theme.taglist_bg_focus = "#000000"
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus = theme.fg_normal
-- theme.tasklist_plain_task_name = true
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
theme.hotkeys_modifiers_fg = "#ffffff"
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
theme.notification_font = theme.font 
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_bg = "#252525"
-- theme.notification_border_width = 0

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width = dpi(200)

theme.menubar_border_width = dpi(0)
theme.menubar_border_color = "#00000000"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"




-- theme.wallpaper = themes_path .. "default/background.png"
theme.wallpaper = "/home/maryll/Pictures/Wallpapers/firewatch.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height,theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- theme.icon_theme = '/usr/share/icons/Arc'

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule = {urgency = 'critical'},
        properties = {bg = '#ff0000', fg = '#ffffff'}
    }
end)



-- tag preview widget
theme.tag_preview_widget_border_radius = 5 -- Border radius of the widget (With AA)
theme.tag_preview_client_border_radius = 5 -- Border radius of each client in the widget (With AA)
theme.tag_preview_client_opacity = 1 -- Opacity of each client
theme.tag_preview_client_bg = theme.darker_bg -- The bg color of each client
theme.tag_preview_client_border_color = theme.border_color_active -- The border color of each client
theme.tag_preview_client_border_width = 0 -- The border width of each client
theme.tag_preview_widget_bg = "#000000" -- The bg color of the widget
theme.tag_preview_widget_border_color = "#000000" -- The border color of the widget
theme.tag_preview_widget_border_width = 0 -- The border width of the widget
theme.tag_preview_widget_margin = 5 -- The margin of the widget

-- window switcher widget
theme.window_switcher_widget_bg = "#00000060"              -- The bg color of the widget
theme.window_switcher_widget_border_width = 0            -- The border width of the widget
theme.window_switcher_widget_border_radius = 10          -- The border radius of the widget
theme.window_switcher_widget_border_color = theme.border_color_active    -- The border color of the widget
theme.window_switcher_clients_spacing = 20               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = 5 -- The space between client icon and text
theme.window_switcher_client_width = 400                 -- The width of one client widget
theme.window_switcher_client_height = 300              -- The height of one client widget
theme.window_switcher_client_margins = 10                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = 10             -- The margin between one client thumbnail and the rest of the widget
theme.thumbnail_scale = false                            -- If set to true, the thumbnails fit policy will be set to "fit" instead of "auto"
theme.window_switcher_name_margins = 10                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_valign = "center"             -- How to vertically align one clients title
theme.window_switcher_name_forced_width = 400            -- The width of one title
theme.window_switcher_name_font = "sans 11"              -- The font of all titles
theme.window_switcher_name_normal_color = "#ffffff"      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.border_color_active       -- The color of one title if the client is focused
theme.window_switcher_icon_valign = "center"             -- How to vertically align the one icon
theme.window_switcher_icon_width = 20                    -- The width of one icon


theme.wibar_height = dpi(35)

return theme


