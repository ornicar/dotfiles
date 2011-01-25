theme = {}

theme.font          = "Inconsolata 12"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#cccccc"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "0"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = "/home/thib/.config/awesome/themes/cruiser/taglist/squarefw.png"
theme.taglist_squares_unsel = "/home/thib/.config/awesome/themes/cruiser/taglist/squarew.png"

theme.tasklist_floating_icon = "/home/thib/.config/awesome/themes/cruiser/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/thib/.config/awesome/themes/cruiser/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/thib/.config/awesome/themes/cruiser/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/thib/.config/awesome/themes/cruiser/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/thib/.config/awesome/themes/cruiser/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/thib/.config/awesome/themes/cruiser/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/thib/.config/awesome/themes/cruiser/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/thib/.config/awesome/themes/cruiser/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/thib/.config/awesome/themes/cruiser/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/thib/.config/awesome/themes/cruiser/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/thib/.config/awesome/themes/cruiser/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/thib/.config/awesome/themes/cruiser/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/thib/.config/awesome/themes/cruiser/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/thib/.config/awesome/themes/cruiser/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/thib/.config/awesome/themes/cruiser/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/thib/.config/awesome/themes/cruiser/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/thib/.config/awesome/themes/cruiser/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/thib/.config/awesome/themes/cruiser/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/thib/.config/awesome/themes/cruiser/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/thib/.config/awesome/themes/cruiser/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg -a /home/thib/data/Images/cc-wallpaper-desktop.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/thib/.config/awesome/themes/cruiser/layouts/fairhw.png"
theme.layout_fairv = "/home/thib/.config/awesome/themes/cruiser/layouts/fairvw.png"
theme.layout_floating  = "/home/thib/.config/awesome/themes/cruiser/layouts/floatingw.png"
theme.layout_magnifier = "/home/thib/.config/awesome/themes/cruiser/layouts/magnifierw.png"
theme.layout_max = "/home/thib/.config/awesome/themes/cruiser/layouts/maxw.png"
theme.layout_fullscreen = "/home/thib/.config/awesome/themes/cruiser/layouts/fullscreenw.png"
theme.layout_tilebottom = "/home/thib/.config/awesome/themes/cruiser/layouts/tilebottomw.png"
theme.layout_tileleft   = "/home/thib/.config/awesome/themes/cruiser/layouts/tileleftw.png"
theme.layout_tile = "/home/thib/.config/awesome/themes/cruiser/layouts/tilew.png"
theme.layout_tiletop = "/home/thib/.config/awesome/themes/cruiser/layouts/tiletopw.png"
theme.layout_spiral  = "/home/thib/.config/awesome/themes/cruiser/layouts/spiralw.png"
theme.layout_dwindle = "/home/thib/.config/awesome/themes/cruiser/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4
