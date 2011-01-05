-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--require("vicious")
-- Load Debian menu entries
require("debian.menu")
-- Custom libraries
require("revelation")
require("vicious")
require("teardrop")
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/engil/.config/awesome/themes/lapin/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
modkey2 = "Mod3"
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
  --  awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
  --  awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
    tags[s][1].name = '[Xvt]'
    tags[s][2].name = '[www]'
    tags[s][3].name = '[irc]'
    tags[s][4].name = '[mail]'
    tags[s][5].name = '[med]'
    tags[s][6].name = '[Î±]'
    tags[s][7].name = '[Ã]'
    tags[s][8].name = '[Î³]'
    tags[s][9].name = '[Î´]'
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

--- {{ Section des Widgets

-- Date


datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)

-- Mem Widget
	

memwidget = awful.widget.progressbar({ layout = awful.widget.layout.horizontal.rightleft })
memwidget:set_width(50)
memwidget:set_height(15)
memwidget:set_background_color(beautiful.fg_focus)
memwidget:set_border_color("#FFFFFF")
memwidget:set_color("#AECF96")
memwidget:set_gradient_colors({ beautiful.fg_widget, theme.fg_center_widget, theme.fg_end_widget })
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)

-- CPU Widget

cpuwidget = awful.widget.graph({ layout = awful.widget.layout.horizontal.rightleft })
cpuwidget:set_width(50)
cpuwidget:set_height(15)
cpuwidget:set_border_color("#FFFFFF")
cpuwidget:set_background_color(beautiful.fg_focus)
cpuwidget:set_color(beautiful.fg_focus)
cpuwidget:set_gradient_colors({ beautiful.fg_widget, theme.fg_center_widget, theme.fg_end_widget })

vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

-- Widget MPD

mpdwidget = widget({ type = "textbox", name = "mpdwidget" })
vicious.register(mpdwidget, vicious.widgets.mpd, " $1", 5, { 30, "mpd" })

-- Net Widget
netwidget       = widget({ type = "textbox", name = "netwidget" })
vicious.register(netwidget, vicious.widgets.net, '<span color="'.. beautiful.fg_end_widget ..'">${eth0 down_kb}</span> <span color="'.. beautiful.fg_widget ..'">${eth0 up_kb}</span>', 3)

-- FS Widget
fswidget       = widget({ type = "textbox", name = "fswidget" })
vicious.register(fswidget, vicious.widgets.fs,
' ${/home used_gb}<span color="'.. beautiful.fg_widget ..'"> /</span> ${/home size_gb} ', 120)


-- Icones

mycpuicon        = widget({ type = "imagebox", name = "mycpuicon" })
mycpuicon.image  = image(beautiful.widget_cpu)


myneticon         = widget({ type = "imagebox", name = "myneticon" })
myneticonup       = widget({ type = "imagebox", name = "myneticonup" })

myneticonup.image = image(beautiful.widget_netup)
myneticon.image   = image(beautiful.widget_net)

myvolicon       = widget({ type = "imagebox", name = "myvolicon" })
myvolicon.image = image(beautiful.widget_vol)

mymusicicon     = widget({ type = "imagebox", name = "mymusicicon"})
mymusicicon.image = image(beautiful.widget_music)

myspacer         = widget({ type = "textbox", name = "myspacer" })
myseparator      = widget({ type = "textbox", name = "myseparator" })

myspacer.text    = " "
myseparator.text = "|"

mydiskicon         = widget({ type = "imagebox", name = "mydiskicon" })
mytimeicon       = widget({ type = "imagebox", name = "mytimeicon" })
mytimeicon.image = image(beautiful.widget_date)
mydiskicon.image   = image(beautiful.widget_fs)

mymemicon       = widget({ type = "imagebox", name = "mymemicon" })
mymemicon.image = image(beautiful.widget_mem)


 -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { 
        {
       --     mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.rightleft
        },
        mylayoutbox[s],
  --      memwidget,       
        datewidget, mytimeicon,
        s == 1 and mysystray or nil,
        myspacer,
        mpdwidget, mymusicicon,  
        myspacer,
        fswidget, mydiskicon,
        myspacer,
        myneticonup, netwidget, myneticon,
        myspacer,
        cpuwidget,
        mycpuicon,
        myspacer,
        memwidget,
        mymemicon, 
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, "Shift"         }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),


  -- Layout manipulationi
    awful.key({ modkey,           }, "Tab", function () awful.client.focus.byidx( 1)    end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey, "Shift"   }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
   -- awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey           },"x",      function () teardrop("urxvtc", "center") end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey2           }, "space", revelation.revelation),                    
 -- Keybindings Perso
    awful.key({ modkey2}, "Left", function () awful.util.spawn("amixer -q sset Front 2dB-") end),
    awful.key({ modkey2}, "Right", function () awful.util.spawn("amixer -q sset Front 2dB+") end),
    awful.key({ modkey}, "v", function () awful.util.spawn("apps") end),


    -- Prompt
    awful.key({ modkey },            "BackSpace",     function () mypromptbox[mouse.screen]:run() end)

 --   awful.key({ modkey }, "x",
   --           function ()
     --             awful.prompt.run({ prompt = "Run Lua code: " },
       --           mypromptbox[mouse.screen].widget,
         --         awful.util.eval, nil,
           --       awful.util.getdir("cache") .. "/history_eval")
             -- end)


  
 --   awful.key({ modkey },       "F2",
          --  function ()
            --        awful.prompt.run({ prompt = "Upload: " },
          --          mypromptbox[mouse.screen].widget,
        --            function (s)
      --                      awful.util.spawn("scp" .. s .. "")
    --                end)
  --          end)

)
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      function (c) c.sticky = not c.sticky end        ),
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
--    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule. 


    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true, opacity = 1.0 } },
    { rule = { class = "lxappearence", "^Download$"  },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true, tag = tags[1][8], opacity = 1.0 } },
    -- Set Firefox to always map on tags number 2 of screen 1.
     { rule = { class = "Iceweasel", opacity = 1.0 },
       properties = { tag = tags[1][2] } },

         { rule = { name = "weechat" },
      properties = { tag = tags[1][3] } },

                 { rule = { name = "med" },
      properties = { tag = tags[1][5] } },

         { rule = { name  = "alpine" },
      properties = { tag = tags[1][4] } },

     
         { rule = { name = "msg" },
      properties = { tag = tags[1][9] } },


         { rule = { class = "gpicview", "epdfview" },
      properties = { tag = tags[1][6], opacity = 1.0 } },


         { rule = { class = "VirtualBox" },
      properties = { tag = tags[1][7], floating = true, opacity = 1.0 } },
       
--         { rule = { class = "urxvt" },
  --       properties = { opacity = 0.95 } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

client.add_signal("focus", function(c)
  c.border_color = beautiful.border_focus
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_focus
  end
end)

client.add_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
  if c.opacity < 1.0 then
    c.opacity = beautiful.opacity_normal
  end
end)
-- }}}
