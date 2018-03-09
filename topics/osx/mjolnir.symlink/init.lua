local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"

ext = {}
require "grid"

local hyper = {"cmd", "alt", "shift", "ctrl"}

local function reloading()
  alert.show("Reloading Mjolnir config", 0.25)
  mjolnir.reload()
end

local function launch(app)
  alert.show("Opening " .. app, 0.25)
  application.launchorfocus(app)
end

local function runcommand(app, cmd)
  alert.show("Opening " .. app, 0.25)
  os.execute(cmd)
end

hotkey.bind(hyper, 'R', reloading)
hotkey.bind(hyper, 'P', function() launch("Slack") end)
hotkey.bind(hyper, 'U', function() launch("iTerm") end)
hotkey.bind(hyper, 'I', function() runcommand("IntelliJ IDEA", "/usr/local/bin/idea") end)
hotkey.bind(hyper, 'O', function() launch("Google Chrome") end)

hotkey.bind(hyper, ';', function() ext.grid.snap(window.focusedwindow()) end)
hotkey.bind(hyper, "'", function() fnutils.map(window.visiblewindows(), ext.grid.snap) end)

hotkey.bind(hyper, '=', function() ext.grid.adjustwidth( 1) end)
hotkey.bind(hyper, '-', function() ext.grid.adjustwidth(-1) end)

hotkey.bind(hyper, 'M', ext.grid.maximize_window)

hotkey.bind(hyper, 'N', ext.grid.pushwindow_nextscreen)
hotkey.bind(hyper, 'P', ext.grid.pushwindow_prevscreen)

hotkey.bind(hyper, 'J', ext.grid.pushwindow_down)
hotkey.bind(hyper, 'K', ext.grid.pushwindow_up)
hotkey.bind(hyper, 'H', ext.grid.pushwindow_left)
hotkey.bind(hyper, 'L', ext.grid.pushwindow_right)

hotkey.bind(hyper, '[', ext.grid.resizewindow_taller)
hotkey.bind(hyper, ']', ext.grid.resizewindow_shorter)
hotkey.bind(hyper, '.', ext.grid.resizewindow_wider)
hotkey.bind(hyper, ',', ext.grid.resizewindow_thinner)

-- default positions
hotkey.bind(hyper, '1', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 1; f.h = 2; end) end)
hotkey.bind(hyper, '2', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 2; f.h = 2; end) end)
hotkey.bind(hyper, '3', function() ext.grid.adjust_focused_window(function(f) f.y = 0; f.w = 3; f.h = 2; end) end)
