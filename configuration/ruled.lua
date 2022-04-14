local awful = require "awful"
local beautiful = require "beautiful"
local ruled = require "ruled"

-- {{{ Rules
-- Rules to apply to new clients.

ruled.client.connect_signal("request::rules", function()

    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.centered  + awful.placement.no_offscreen
        }
    }

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

    -- Picture in picture
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

    -- removing border and tiling for teamviewer
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
                "CPU Simulator", "pavucontrol", "Pavucontrol", "matplotlib", "Wihotspot-gui",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown thfloatingere might not match defined rules here.
            name = {
                "Event Tester", -- xev.
                "Volume Control",
                "PlayOnLinux"
                -- "Picture in picture"
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                -- "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        except_any = {
            class = {"crx_peoigcfhkflakdcipcclkneidghaaphd"},
            name = {"csTimer"}
        },
        properties = {floating = true, titlebars_enabled = true}
    }

    ruled.client.append_rule {
        id = "Cs timer",
        rule_any = {
            -- class = {"crx_peoigcfhkflakdcipcclkneidghaaphd"},
            name = {"csTimer"}

        },
        properties = {
            tiled = true,
            
        }
    }

end)

-- }}}