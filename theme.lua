local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local notification = require("naughty.notification")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

require("colors")

local theme = {}

theme.font = "Sans Regular 11"
theme.taglist_font = "18"


-- theme.tasklist_plain_task_name = false
-- theme.tasklist_disable_task_name = true

theme.bg_normal = gruvbox.bg0_h
-- theme.bg_focus = gruvbox.bg0
theme.bg_focus = "#ffffff" .. 15
-- theme.bg_urgent = theme.bg_normal
theme.bg_minimize = theme.bg_normal
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.systray_icon_spacing = dpi(2)
theme.bg_systray = gruvbox.red

theme.fg_normal = gruvbox.fg0
theme.fg_focus = gruvbox.aqua
theme.fg_urgent = gruvbox.red
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(3)
theme.gap_single_client = true
theme.border_width = dpi(1)
theme.border_color_normal = gruvbox.bg0
theme.border_color_active = gruvbox.aqua
theme.border_color_marked = gruvbox.red

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- theme.taglist_bg_focus = "#000000"
-- tasklist_[bg|fg]_[focus|urgent]
theme.tasklist_fg_focus = theme.fg_normal
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- theme.notification_font = theme.font .. "15"
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

theme.notification_bg = "#252525"
-- theme.notification_border_width = 0

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path ..
                                         "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path ..
                                        "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path ..
                                            "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = themes_path ..
                                           "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive =
    themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive =
    themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active =
    themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active =
    themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive =
    themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive =
    themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active =
    themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active =
    themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive =
    themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive =
    themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active =
    themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active =
    themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive =
    themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive =
    themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active =
    themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active =
    themes_path .. "default/titlebar/maximized_focus_active.png"

-- theme.wallpaper = themes_path .. "default/background.png"
theme.wallpaper = "/home/maryll/Pictures/Wallpapers/cool-mountains.jpg"

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
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height,
                                               theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = '/usr/share/icons/gnome'

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule = {urgency = 'critical'},
        properties = {bg = '#ff0000', fg = '#ffffff'}
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
