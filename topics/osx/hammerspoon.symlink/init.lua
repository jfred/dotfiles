local hotkey = require "hs.hotkey"
local grid = require "hs.grid"
local app = require "hs.application"
local gridDims = {6, 5}

local mega = {"cmd", "alt", "shift"}
local hyper = {"cmd", "ctrl", "shift"}
local super = {"ctrl", "alt", "cmd"}

local logger = hs.logger.new('init', 5)

local function reloading()
  hs.alert("Reloading HS config...")
  hs.reload()
end

local function rebinder(mod)
  return function(char, func)
    hotkey.deleteAll(mod, char)
    hotkey.bind(mod, char, func)
  end
end

local bindMega = rebinder(mega)
local bindHyper = rebinder(hyper)
local bindSuper = rebinder(super)

local function bindAll(char, func)
  bindMega(char, func)
  bindHyper(char, func)
  bindSuper(char, func)
end

-- default grid
hs.grid.ui.textSize = 60
hs.grid.ui.showExtraKeys = false
hs.grid.ui.highlightStrokeWidth = 10
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
  increaseGridDim(2, 5)
end

function decreaseGridHeight()
  decreaseGridDim(2)
end

-- reload config
bindAll("R", reloading)

-- move mouse
local function moveMouseToNextScreen()
    local currentScreen = hs.mouse.getCurrentScreen()
    local nextScreen = currentScreen:next()

    local currentPos = hs.mouse.getAbsolutePosition()
    local newFrame = nextScreen:frame()

    -- Calculate new mouse position relative to the next screen
    local newX = newFrame.x + (currentPos.x - currentScreen:frame().x) / currentScreen:frame().w * nextScreen:frame().w
    local newY = newFrame.y + (currentPos.y - currentScreen:frame().y) / currentScreen:frame().h * nextScreen:frame().h

    -- Move the mouse to the new position
    hs.mouse.setAbsolutePosition({x = newX, y = newY})
end

bindAll("8", moveMouseToNextScreen)


-- grid
hs.window.animationDuration = 0 -- disable animations
bindAll('E', grid.toggleShow)
bindAll(';', grid.snap)
bindAll('=', increaseGridWidth)
bindAll('-', decreaseGridWidth)
bindAll('0', increaseGridHeight)
bindAll('9', decreaseGridHeight)


-- move windows
bindAll('J', grid.pushWindowDown)
bindAll('K', grid.pushWindowUp)
bindAll('H', grid.pushWindowLeft)
bindAll('L', grid.pushWindowRight)

-- resize windows
bindAll('[', grid.resizeWindowShorter)
bindAll(']', grid.resizeWindowTaller)
bindAll('.', grid.resizeWindowWider)
bindAll(',', grid.resizeWindowThinner)
bindAll('M', grid.maximizeWindow)

bindAll('C', function()
  local win = hs.window.focusedWindow()
  win:centerOnScreen()
end)

-- major moves
local function genFocusWinModder(mod)
  return function()
    -- get the focused window
    local win = hs.window.focusedWindow()
    local screengrid = grid.getGrid(winscreen)
    local target = {
      screengrid.w * mod[1],
      screengrid.h * mod[2],
      screengrid.w * mod[3],
      screengrid.h * mod[4]
    }
    grid.set(win, target)
  end
end

bindSuper('Right', genFocusWinModder({.5, 0, 1, 1}))
bindSuper('Left', genFocusWinModder({0, 0, .5, 1}))
bindSuper('Up', genFocusWinModder({0, 0, 1, .5}))
bindSuper('Down', genFocusWinModder({0, .5, 1, 1}))

-- move windows
bindAll('N', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect 
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- toggle dark mode
bindHyper('U', function()
  hs.applescript('tell application "System Events"\ntell appearance preferences\nset dark mode to not dark mode\nend tell\nend tell\n')
end)

-- bind applications
hs.application.enableSpotlightForNameSearches(true)

local function launcher(app)
  return function()
    hs.application.launchOrFocus(app)
  end
end


local apps = {}
apps["P"]=launcher('Slack')
apps["O"]=launcher('Google Chrome')
apps["I"]=launcher('iTerm')
apps["J"]=launcher('IntelliJ IDEA')
apps["U"]=launcher('Safari')
apps["["]=launcher('Obsidian')

local launch_modifier = {"ctrl", "alt"}
for char, launcher in pairs(apps) do
  hotkey.deleteAll(launch_modifier, char)
  hotkey.bind(launch_modifier, char, launcher)
end

-- text
hotkey.bind(hyper, "V", function()
  local time = os.date("%Y-%m-%d %H:%M %Z")
  hs.alert.show(time)
  hs.pasteboard.setContents(time)
end)

-- layouts
-- get screen names from hs.screen.allScreens()[1]:name() or similar in the console
bindAll('1', function ()
  -- local laptopScreen = 'Built-in Retina Display'
  local laptopScreen = nil
  local laptopLayout = {
    {'Slack', nil, laptopScreen, hs.layout.maximized, nil, nil},
    {'iTerm2', nil, laptopScreen, nil, nil, has.grid.getGridFrame()}
  }
  hs.layout.apply(laptopLayout)
end)

setGrid()
hs.alert('HS loaded')
