local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"

ext = {}
require "grid"

local mash = {"cmd", "shift", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}

local function opendictionary()
  alert.show("Lexicon, at your service.", 0.75)
  application.launchorfocus("Dictionary")
end

local function reloading()
  alert.show("Reloading Mjolnir config", 0.75)
  mjolnir.reload()
end

local function launch(app)
  alert.show("Opening " .. app, 0.25)
  application.launchorfocus(app)
end

hotkey.bind(mash, 'R', reloading)
hotkey.bind(mash, 'D', opendictionary)
hotkey.bind(mash, '`', function() launch("iTerm") end)
hotkey.bind(mash, 'S', function() launch("Slack") end)
hotkey.bind(mash, 'I', function() launch("IntelliJ IDEA") end)

hotkey.bind(mash, ';', function() ext.grid.snap(window.focusedwindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), ext.grid.snap) end)

hotkey.bind(mash, '=', function() ext.grid.adjustwidth( 1) end)
hotkey.bind(mash, '-', function() ext.grid.adjustwidth(-1) end)

hotkey.bind(mash, 'M', ext.grid.maximize_window)

hotkey.bind(mash, 'N', ext.grid.pushwindow_nextscreen)
hotkey.bind(mash, 'P', ext.grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', ext.grid.pushwindow_down)
hotkey.bind(mash, 'K', ext.grid.pushwindow_up)
hotkey.bind(mash, 'H', ext.grid.pushwindow_left)
hotkey.bind(mash, 'L', ext.grid.pushwindow_right)

hotkey.bind(mash, '[', ext.grid.resizewindow_taller)
hotkey.bind(mash, ']', ext.grid.resizewindow_shorter)
hotkey.bind(mash, '.', ext.grid.resizewindow_wider)
hotkey.bind(mash, ',', ext.grid.resizewindow_thinner)

-- default positions
hotkey.bind(mash, '1', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 1; f.h = 2; end) end)
hotkey.bind(mash, '2', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 2; f.h = 2; end) end)
hotkey.bind(mash, '3', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 3; f.h = 2; end) end)
