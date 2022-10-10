dimensions = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  right33       = { x = 2/3,  y = 0.00, w = 1/3,  h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  left33        = { x = 0.00, y = 0.00, w = 1/3,  h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

prevFrame = nil
prevWindowId = nil

function leftHalf()
  hs.window.focusedWindow():move(dimensions.left50)
end

function leftThird()
  hs.window.focusedWindow():move(dimensions.left33)
end

function rightHalf()
  hs.window.focusedWindow():move(dimensions.right50)
end

function rightThird()
  hs.window.focusedWindow():move(dimensions.right33)
end

function handleRightHotkey()
  local window = hs.window.focusedWindow()
  local screenDims = getScreenDimensions()
  local windowFrame = window:frame()

  if (windowFrame.x + windowFrame.w) == screenDims.w and windowFrame.x >= (screenDims.w / 2) and windowFrame.x < (screenDims.w * (2/3)) then
    rightThird()
  else
    rightHalf()
  end

  -- local screenRight50 = hs.geometry.rect(dimensions.right50):fromUnitRect(screenDims)
  -- local screenRight33 = hs.geometry.rect(dimensions.right33):fromUnitRect(screenDims)

  -- if windowFrame:inside(screenRight50) and not windowFrame:inside(screenRight33) then
  --   rightThird()
  -- else
  --   rightHalf()
  -- end
end

function handleLeftHotkey()
  local window = hs.window.focusedWindow()
  local screenDims = getScreenDimensions()
  local windowFrame = window:frame()

  if windowFrame.x == 0 and windowFrame.w > (screenDims.w / 3) and windowFrame.w <= (screenDims.w / 2) then
    leftThird()
  else
    leftHalf()
  end

  -- local screenLeft50 = hs.geometry.rect(dimensions.left50):fromUnitRect(screenDims)
  -- local screenLeft33 = hs.geometry.rect(dimensions.left33):fromUnitRect(screenDims)

  -- if windowFrame:inside(screenLeft50) and not windowFrame:inside(screenLeft33) then
  --   leftThird()
  -- else
  --   leftHalf()
  -- end
end

function isMaximized(window)
  return hs.window.focusedWindow():screen():frame().size == window:size()
end

function maximize()
  local window = hs.window.focusedWindow()
  local stashedFrame = window:frame()

  if isMaximized(window) and prevWindowId == window:id() then
    hs.window.focusedWindow():move(prevFrame)
  else
    hs.window.focusedWindow():maximize()
  end

  prevFrame = stashedFrame
  prevWindowId = window:id()
end

function getScreenDimensions()
  return hs.window.focusedWindow():screen():frame()
end

hs.window.animationDuration = 0

hs.hotkey.bind({"alt", "ctrl"}, "Left", handleLeftHotkey)
hs.hotkey.bind({"alt", "ctrl"}, "Right", handleRightHotkey)
hs.hotkey.bind({"alt", "ctrl"}, "Return", maximize)
