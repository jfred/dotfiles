local hotkey = require "hs.hotkey"
local grid = require "hs.grid"
local app = require "hs.application"
local gridDims = {4, 3}

local mega = {"cmd", "alt", "shift"}
local hyper = {"cmd", "ctrl", "shift"}

local apps = {
    P='Slack',
    U='iTerm',
    O='Google Chrome',
    I='IntelliJ IDEA',
    Y='Pocket Casts'
}

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
function printGrid()
    local s = string.format('%sx%s', gridDims[1], gridDims[2])
    hs.alert(string.format("grid: %s", s))
end
function setGrid()
    local s = string.format('%sx%s', gridDims[1], gridDims[2])
    grid.setGrid(s)
end

function increaseGridDim(index, max)
    if gridDims[index] < max then
        gridDims[index] = gridDims[index] + 1
        setGrid()
    end
    printGrid()
end

function decreaseGridDim(index)
    if gridDims[index] > 1 then
        gridDims[index] = gridDims[index] - 1
        setGrid()
    end
    printGrid()
end

function increaseGridWidth()
    increaseGridDim(1, 6)
end

function decreaseGridWidth()
    decreaseGridDim(1)
end

function increaseGridHeight()
    increaseGridDim(2, 4)
end

function decreaseGridHeight()
    decreaseGridDim(2)
end

-- reload config
superbind("R", reloading)

-- grid
hs.window.animationDuration = 0 -- disable animations
superbind('E', grid.toggleShow)
superbind(';', grid.snap)
superbind('=', increaseGridWidth)
superbind('-', decreaseGridWidth)
superbind('0', increaseGridHeight)
superbind('9', decreaseGridHeight)


-- move windows
superbind('J', grid.pushWindowDown)
superbind('K', grid.pushWindowUp)
superbind('H', grid.pushWindowLeft)
superbind('L', grid.pushWindowRight)

-- resize windows
superbind('[', grid.resizeWindowShorter)
superbind(']', grid.resizeWindowTaller)
superbind('.', grid.resizeWindowWider)
superbind(',', grid.resizeWindowThinner)
superbind('M', grid.maximizeWindow)

-- bind applications
for key, name in pairs(apps) do
    superbind(key, launch(name))
end

setGrid()
hs.alert('HS loaded')
