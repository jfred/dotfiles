local hotkey = require "hs.hotkey"
local grid = require "hs.grid"
local app = require "hs.application"
local gridDims = {6, 4}

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

-- move windows
superbind('N', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect 
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- bind applications
hs.application.enableSpotlightForNameSearches(true)

local function launcher(app)
  return function()
    appFound = hs.application.find(app)
    if appFound then
      hs.application.launchOrFocusByBundleID(appFound:bundleID())
    else
      hs.alert("No app found: " .. app)
    end
  end
end


local apps = {
  P=launcher('Slack'),
  O=launcher('Google Chrome'),
  I=launcher('iTerm'),
  J=launcher('IntelliJ IDEA'),
}

local launch_modifier = {"ctrl", "alt"}
for char, launcher in pairs(apps) do
  hotkey.deleteAll(launch_modifier, char)
  hotkey.bind(launch_modifier, char, launcher)
end

setGrid()
hs.alert('HS loaded')
