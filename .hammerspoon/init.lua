local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

function switchDisplay()
  local screen = hs.mouse.getCurrentScreen():next()

  local windows = hs.fnutils.filter(
    hs.window.allWindows(),
    function (win)
      return win:screen() == screen
    end
  )

  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen so that changing desktop works
  hs.mouse.absolutePosition(screen:fullFrame().center)
  hs.mouse.absolutePosition(screen:fullFrame().bottomright)

  hs.alert.show('Focused', {}, screen, 0.5)
end

function dismissNotification()
  hs.notify.withdrawAll()
end

function chromeToggleSearchBar()
  local currentApplication = hs.application.frontmostApplication()
  if currentApplication:name() == 'Google Chrome' then
    local focussedElement = hs.uielement.focusedElement():role()
    if focussedElement == 'AXTextField' then
      hs.eventtap.keyStroke('cmd', 'a')
      hs.eventtap.keyStrokes('javascript:()')
      hs.eventtap.keyStroke({}, "return")
    else
      hs.eventtap.keyStroke('cmd', 'l', 200000, currentApplication)
    end
  end
end

hs.hotkey.bind('cmd', '`', switchDisplay)
hs.hotkey.bind('cmd', 'q', dismissNotification)
hs.hotkey.bind('cmd', 'l', chromeToggleSearchBar)

vim
  :disableForApp('Code')
  :disableForApp('MacVim')
  :disableForApp('zoom.us')
  :bindHotKeys({ enter = {{'ctrl'}, '\\'} })

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
