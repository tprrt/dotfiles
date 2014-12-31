--------------
-- Required --
--------------

-- Standard awesome library
require("awful")

-- Theme handling library
require("beautiful")

-- Notification library
require("naughty")

-- Dynamics tags library
--require("wicked")

--------------
-- xcompmgr --
--------------

os.execute ("xcompmgr -fF -D6 -cC -t -5 -l-6 -r5 &")

----------------
-- Enviroment --
----------------

home = os.getenv("HOME")

-----------
-- Theme --
-----------

theme_path = home .. "/.config/awesome/theme.lua"
beautiful.init(theme_path)

------------------
-- Applications --
------------------

-- to execute tty application in a terminal
function command(term,app)
    return term .. " -name " .. app .. " -e " .. app
end

terminal = "urxvt"

editor = os.getenv("EDITOR") or "nano"
editor2 = "emacs -nw"
xeditor = "emacs"

browser = "firefox"
browser_tty = "links" --tty application
file_manager = "vifm" --tty application
volume = "alsamixer" --tty applciation
monitor = "htop" --tty application

pdf_viewer = "apvlv"
image_viewer = "mirage"
video_player = "mplayer" --pas dans le menu
audio_player = "cmus" --tty application

java_editor = "eclipse"
math_editor = "qtoctave"

client_mail = "mutt" --tty application
client_irc = "irssi" --tty application
client_nzb = "nzbget" --tty application
client_torrent = "rtorrent" --tty application

-------------
-- Layouts --
-------------
layouts =
{
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}

-----------------------------
-- Table of floatings apps --
-----------------------------

floatapps =
{
    -- by class
    --["mplayer"] = true,

    -- by instance
    --["htop"] = true,
    --["mutt"] = true,
    --["irssi"] = true,
    --["hellanzb"] = true,
    --["rtorrent"] = true
}

-------------------------
-- Table of moved apps --
-------------------------

--Use by hooks to move client to reserved tag
apptags =
{
    [terminal] = { screen = 1, tag = 1 },
    [file_manager] = { screen = 1, tag = 2 },
    [volume] = { screen = 1, tag = 2 },
    [monitor] = { screen = 1, tag = 2 },
    [browser] = { screen = 1, tag = 3 },
    [browser_tty] = { screen = 1, tag = 3 },
    [client_mail] = { screen = 1, tag = 3 },
    [client_irc] = { screen = 1, tag = 3 },
    [client_nzb] = { screen = 1, tag = 3 },
    [client_torrent] = { screen = 1, tag = 3 },
    [editor] = { screen = 1, tag = 4 },
    [editor2] = { screen = 1, tag = 4 },
    [xeditor] = { screen = 1, tag = 4 },
    [java_editor] = { screen = 1, tag = 4 },
    [math_editor] = { screen = 1, tag = 4 },
    [image_viewer] = { screen = 1, tag = 5 },
    [pdf_viewer] = { screen = 1, tag = 5 },
    [audio_player] = { screen = 1, tag = 5 },
    [video_player] = { screen = 1, tag = 1 }
}

------------------------
-- Tags configuration --
------------------------

tagTerm = tag(1)
tagTerm.name = 'term'
--tagTerm.layout = 'max'
tagTerm.screen = 1
tagTerm.selected = true
awful.layout.set(layouts[1],tagTerm)

tagSys = tag(2)
tagSys.name = 'sys'
--tagSys.layout = 'max'
tagSys.screen = 1
awful.layout.set(layouts[1],tagSys)

tagWww = tag(3)
tagWww.name = 'www'
--tagWww.layout = 'max'
tagWww.screen = 1
awful.layout.set(layouts[1],tagWww)

tagDev = tag(4)
tagDev.name = 'dev'
--tagDev.layout = 'max'
tagDev.screen = 1
awful.layout.set(layouts[1],tagDev)

tagMisc = tag(5)
tagMisc.name = 'misc'
--tagMisc.layout = 'max'
tagMisc.screen = 1
awful.layout.set(layouts[1],tagMisc)

------------------------
-- Menu configuration --
------------------------

mainmenu = awful.menu.new({
    items = {
        { terminal, terminal },
        { browser, browser },
        { xeditor, xeditor },
--        { editor, command(terminal,editor)},
        { client_mail, command(terminal,client_mail) },
        { client_irc, command(terminal,client_irc) },
        { client_nzb, command(terminal,client_nzb) },
        { client_torrent, command(terminal,client_torrent) },
        { image_viewer, image_viewer},
        { audio_player, command(terminal,audio_player) },
        { monitor, command(terminal,monitor) },
        { java_editor, java_editor },
        { math_editor, math_editor },
        { pdf_viewer, pdf_viewer },
        { browser_tty, command(terminal,browser_tty) },
        { file_manager, command(terminal,file_manager) },
        { volume, command(terminal,volume) },
        { "quit", awesome.quit }
    }
})

---------------------
-- Buttons binding --
---------------------

buttons = awful.util.table.join(
    --Open/Close menu
    awful.button({ }, 3, function () menu:toggle() end),
    --Go to the next tag
    awful.button({ }, 4, awful.tag.viewnext),
    --Go to the previous tag
    awful.button({ }, 5, awful.tag.viewprev)
)
root.buttons(buttons)

------------------
-- Keys binding --
------------------

modkey = "Mod1" --Mod1 : Alt --Mod4 : Windows --Control --Alt

keys = awful.util.table.join(
    --Restart Awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    --Quit awesome
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    --Open/Close menu
    awful.key({ modkey, }, "Menu", function () menu:toggle() end),
    --Go to the next tag
    awful.key({ modkey, }, "Left",   awful.tag.viewprev       ),
    --Go to the previous tag
    awful.key({ modkey, }, "Right",  awful.tag.viewnext       ),
    --Focus the previous application
    awful.key({ modkey, }, "Tab", function () awful.client.focus.history.previous() end),
    --Create a screenshot file
    awful.key({ modkey, }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end),
    --Change layout of the current tag
    awful.key({ modkey, }, "space", function () awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    --Kill current application
    awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end)
)
root.keys(keys)

-------------
-- widgets --
-------------

launcher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
				    menu = mainmenu })

tagsList = awful.widget.taglist(1, awful.widget.taglist.label.all)
tagsList.buttons = awful.util.table.join(
			awful.button({ }, 1, awful.tag.viewonly),
			awful.button({ modkey }, 1, awful.client.movetotag),
			awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
			awful.button({ modkey }, 3, awful.client.toggletag),
			awful.button({ }, 4, awful.tag.viewnext),
			awful.button({ }, 5, awful.tag.viewprev)
                   )

tasksList = awful.widget.tasklist(
		function(c) return awful.widget.tasklist.label.currenttags(c) end,
		awful.util.table.join(
			
)

systray = widget({ type = "systray", align = "right" })

timeWidget = widget({ type = "textbox", align = "right" })
timeWidget.text = os.date(" %a %b %d, %H:%M ")

layoutsWidget = widget({ type = "imagebox", align = "right" })
layoutsWidget:buttons(awful.util.table.join(
			awful.button({ }, 1, function () awful.laout.inc(layouts,1) end),
			awful.button({ }, 3, function () awful.laout.inc(layouts,-1) end),
			awful.button({ }, 4, function () awful.laout.inc(layouts,1) end),
			awful.button({ }, 5, function () awful.laout.inc(layouts,1) end)))

-----------
-- wibox --
-----------

wibox = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
wibox.screen = 1
--wibox.position = "top"
wibox.widgets = {
   tagsList,
   tasksList,
   systray,
   timeWidget,
   layoutsWidget
}

-----------
-- Hooks --
-----------

--Use by Hook function register to add titlebar
use_titlebar = false

--Hook function to execute when a new client appear
awful.hooks.manage.register(function (c,startup)

    --Add a titlebar
    if use_titlebar then
        awful.titlebar.add(c, { modkey = modkey })
    end

    --Move client to reserved tag
    local target
    if apptags[c.cls] ~= nil then
        target = apptags[c.cls]
    elseif apptags[c.instance] ~= nil then
        target = apptags[c.instance]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(target.tag,c)
    end
end)

-- Hook function called every 30 secondes
awful.hooks.timer.register(30,function ()
    timeWidget.text = os.date(" %a %b %d, %H:%M ")
end)
