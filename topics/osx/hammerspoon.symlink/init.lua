local hotkey = require "hs.hotkey"
local grid = require "hs.grid"
local app = require "hs.application"
local gridDims = {4, 2}

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
        appFound = hs.application.find(app)
        if appFound then
            hs.application.launchOrFocusByBundleID(appFound:bundleID())
        end
    end
end

-- default grid
function setGrid()
    local s = string.format('%sx%s', gridDims[1], gridDims[2])
    hs.alert(string.format("Setting grid: %s", s))
    grid.setGrid(s)
end

function increaseWidth()
    gridDims[1] = gridDims[1] + 1
    setGrid()
end
function decreaseWidth()
    if gridDims[1] > 1 then
        gridDims[1] = gridDims[1] - 1
        setGrid()
    end
end

-- reload config
superbind("R", reloading)

-- grid
hs.window.animationDuration = 0 -- disable animations
superbind('Y', grid.toggleShow)
superbind(';', grid.snap)
superbind('=', increaseWidth)
superbind('-', decreaseWidth)

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
superbind('I', launch('IntelliJ IDEA'))

setGrid()
hs.alert('HS loaded')
