local hotkey = require "hs.hotkey"
local grid = require "hs.grid"
local app = require "hs.application"

local mega = {"cmd", "alt", "shift"}
local hyper = {"cmd", "ctrl", "shift"}

local function reloading()
    hs.alert("Reloading HS config...")
    hs.reload()
end

local function superbind(char, func)
    hotkey.deleteAll(mega, char)
    hotkey.bind(mega, char, func)

    hotkey.deleteAll(hyper, char)
    hotkey.bind(hyper, char, func)
end

local function launch(app)
    return function()
        hs.application.launchOrFocus(app)
    end
end

-- default grid
grid.setGrid('4x2')

-- reload config
superbind("R", reloading)

-- grid
hs.window.animationDuration = 0 -- disable animations
superbind('Y', grid.toggleShow)
superbind(';', grid.snap)

-- move windows
superbind('j', grid.pushWindowDown)
superbind('K', grid.pushWindowUp)
superbind('H', grid.pushWindowLeft)
superbind('L', grid.pushWindowRight)

-- resize windows
superbind('[', grid.resizeWindowShorter)
superbind(']', grid.resizeWindowTaller)
superbind('.', grid.resizeWindowWider)
superbind(',', grid.resizeWindowThinner)
superbind('M', grid.maximizeWindow)

-- applications
superbind('P', launch('Slack'))
superbind('U', launch('iTerm'))
superbind('O', launch('Google Chrome'))
superbind('I', launch('IntelliJ Idea'))

hs.alert('HS loaded')
