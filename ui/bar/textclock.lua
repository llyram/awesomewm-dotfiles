local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
require("theme.colors")
local gears = require("gears")
clickable_container = require("modules.clickable-container")
local cal = require("ui.bar.calendar")
-- local markup = require("markup")

-- Create a textclock widget
mytextclock = wibox.widget {
  {
    {
        {
          widget = wibox.widget.textclock('<span font="Product Sans Bold 12">%a %b %d, %I:%M %p </span>', 1),
          -- widget = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M " .. markup.font("Roboto 4", " ")))
        },
        widget = wibox.container.margin,
        left = dpi(20),
        right = dpi(15),
        -- color = "#ffffff",
    },
    widget = clickable_container
  },
  widget = wibox.container.background,
  -- bg = nord.nord3,
  shape = gears.shape.rounded_bar
  -- shape = function(cr, width, height)
      -- gears.shape.powerline(cr, width, height, -15)
  -- end,
}
local old_cursor, old_wibox
mytextclock:connect_signal(
  'mouse::enter',
  function()
  -- mytextclock.bg = '#ffffff11'
    -- Hm, no idea how to get the wibox from this signal's arguments...
    local w = _G.mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = 'hand1'
    end
  end
)

mytextclock:connect_signal(
  'mouse::leave',
  function()
  --   mytextclock.bg = '#ffffff00'
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end
)

mytextclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then cal_toggle() end
end)

return mytextclock
