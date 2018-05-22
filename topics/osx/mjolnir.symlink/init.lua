local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"

ext = {}
require "grid"

local hyper = {"cmd", "alt", "shift", "ctrl"}
local mega = {"cmd", "shift", "alt"}

local function reloading()
  alert.show("Reloading Mjolnir config", 0.25)
  mjolnir.reload()
end

local function launch(app)
  -- alert.show("Opening " .. app, 0.25)
  application.launchorfocus(app)
end

local function runcommand(app, cmd)
  -- alert.show("Opening " .. app, 0.25)
  os.execute(cmd)
end

local function superbind(char, func)
  hotkey.bind(hyper, char, func)
  hotkey.bind(mega, char, func)
end

superbind('R', reloading)
superbind('P', function() launch("Slack") end)
superbind('U', function() launch("iTerm") end)
superbind('I', function() runcommand("IntelliJ IDEA", "/usr/local/bin/idea") end)
superbind('O', function() launch("Google Chrome") end)

superbind(';', function() ext.grid.snap(window.focusedwindow()) end)
superbind("'", function() fnutils.map(window.visiblewindows(), ext.grid.snap) end)

superbind('=', function() ext.grid.adjustwidth( 1) end)
superbind('-', function() ext.grid.adjustwidth(-1) end)

superbind('M', ext.grid.maximize_window)

superbind('N', ext.grid.pushwindow_nextscreen)
superbind('P', ext.grid.pushwindow_prevscreen)

superbind('J', ext.grid.pushwindow_down)
superbind('K', ext.grid.pushwindow_up)
superbind('H', ext.grid.pushwindow_left)
superbind('L', ext.grid.pushwindow_right)

superbind('[', ext.grid.resizewindow_taller)
superbind(']', ext.grid.resizewindow_shorter)
superbind('.', ext.grid.resizewindow_wider)
superbind(',', ext.grid.resizewindow_thinner)

-- default positions
superbind('1', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 1; f.h = 2; end) end)
superbind('2', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 2; f.h = 2; end) end)
superbind('3', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 3; f.h = 2; end) end)
