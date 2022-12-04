local Stack = require("./stack")

local dimensions = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  right33       = { x = 2/3,  y = 0.00, w = 1/3,  h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  left33        = { x = 0.00, y = 0.00, w = 1/3,  h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

local prevWindowId = nil
local lastCommand = nil
local undoStack = Stack:new(3)

function leftHalf(window)
  window:move(dimensions.left50)
end

function leftThird(window)
  window:move(dimensions.left33)
end

function rightHalf(window)
  window:move(dimensions.right50)
end

function rightThird(window)
  window:move(dimensions.right33)
end

function handleRightHotkey()
  local window = hs.window.focusedWindow()
  local stashedFrame = window:frame()
  local screenDims = getScreenDimensions()
  local windowFrame = window:frame()

  if (windowFrame.x + windowFrame.w) == screenDims.w and windowFrame.x >= (screenDims.w / 2) and windowFrame.x < (screenDims.w * (2/3)) then
    rightThird(window)
  else
    rightHalf(window)
  end

  undoStack:push(stashedFrame)
  prevWindowId = window:id()
  lastCommand = "right"
end

function handleLeftHotkey()
  local window = hs.window.focusedWindow()
  local stashedFrame = window:frame()
  local screenDims = getScreenDimensions()
  local windowFrame = window:frame()

  if windowFrame.x == 0 and windowFrame.w > (screenDims.w / 3) and windowFrame.w <= (screenDims.w / 2) then
    leftThird(window)
  else
    leftHalf(window)
  end

  undoStack:push(stashedFrame)
  prevWindowId = window:id()
  lastCommand = "left"
end

function handleMaximizeHotkey()
  local window = hs.window.focusedWindow()
  local stashedFrame = window:frame()

  if isMaximized(window) and prevWindowId == window:id() then
    local revertTo = undoStack:pop()
    if revertTo ~= nil then
      hs.window.focusedWindow():move(revertTo)
    end
  else
    hs.window.focusedWindow():maximize()
  end

  undoStack:push(stashedFrame)
  prevWindowId = window:id()
  lastCommand = "maximize"
end

function handleExpandHotkey()
  local window = hs.window.focusedWindow()
  local stashedFrame = window:frame()
  local windowBehind = getWindowBehind(window)

  if windowBehind == nil then
    print("there's no windowBehind!!!!")
    return
  end

  local screenDims = getScreenDimensions()

  -- hotkey should cycle through three states in this order:
  -- - if original frame size -> expand
  -- - if expanded frame size -> maximize
  -- - if maximized frame size -> natural
  if lastCommand == "expand" and prevWindowId == window:id() then
    local weAreExpandedOnRight = (window:frame().x + window:frame().w == screenDims.w)
    local weAreExpandedOnLeft = (0 + window:frame().w == windowBehind:frame().x)

    if isMaximized(window) then
      -- we are maximized. we want to revert to original
      undoStack:pop()
      local revertTo = undoStack:pop()
      if revertTo ~= nil then
        hs.window.focusedWindow():move(revertTo)
      end
      undoStack:push(stashedFrame)
      return
    elseif weAreExpandedOnLeft or weAreExpandedOnRight then
      -- we are expanded. we want to maximize
      window:maximize()
      undoStack:push(stashedFrame)
      return
    else
      -- we are some organic size. we want to expand
      -- continue
    end
  end

  local distanceBetweenWBRightAndScreenRightEdge = screenDims.w - (windowBehind:frame().x + windowBehind:frame().w)
  local distanceBetweenWBLeftAndScreenLeftEdge = 0 + (windowBehind:frame().x)

  if distanceBetweenWBLeftAndScreenLeftEdge > distanceBetweenWBRightAndScreenRightEdge then
    -- windowBehind is "on the right side" so we want to fill the LEFT side of the screen
    local newX = 0
    local newY = screenDims.y
    local newW = 0 + windowBehind:frame().x
    local newH = screenDims.h
    window:move({ x = newX, y = newY, w = newW, h = newH })
  else
    -- windowBehind is "on the left side" so we want to fill the RIGHT side of the screen
    local newX = windowBehind:frame().x + windowBehind:frame().w
    local newY = screenDims.y
    local newW = screenDims.w - (windowBehind:frame().x + windowBehind:frame().w)
    local newH = screenDims.h
    window:move({ x = newX, y = newY, w = newW, h = newH })
  end

  undoStack:push(stashedFrame)
  prevWindowId = window:id()
  lastCommand = "expand"
end

function getWindowBehind(window)
  local stashedFrame = window:frame()
  local r = hs.window.orderedWindows()
  local screenDims = getScreenDimensions()

  for i, w in ipairs(r) do
    local w1 = r[i + 1]
    if w1 == nil then break end
    if window:screen() ~= w:screen() or window:screen() ~= w1:screen() then break end
    if w:id() == window:id() then
      return w1
    end
  end

  return nil
end

function getScreenDimensions()
  return hs.window.focusedWindow():screen():frame()
end

function isMaximized(window)
  return window:screen():frame().size == window:size()
end

function printTable(obj)
  if type(obj) == 'table' then
     local s = '{ \n'
     for k,v in pairs(obj) do
        if type(k) ~= 'number' then k = '"'..k..'"' end
        s = s .. '  ['..k..'] = ' .. printTable(v) .. ',\n'
     end
     return s .. '}'
  else
     return tostring(obj)
  end
end

hs.window.animationDuration = 0

hs.hotkey.bind({"alt", "ctrl"}, "Left", handleLeftHotkey)
hs.hotkey.bind({"alt", "ctrl"}, "Right", handleRightHotkey)
hs.hotkey.bind({"alt", "ctrl"}, "Return", handleMaximizeHotkey)
hs.hotkey.bind({"alt", "ctrl", "cmd"}, "Return", handleExpandHotkey)
