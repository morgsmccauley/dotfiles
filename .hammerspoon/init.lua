function chromeToggleSearchBar()
  local currentApplication = hs.application.frontmostApplication()
  if currentApplication:name() == 'Google Chrome' then
    local focussedElement = hs.uielement.focusedElement():role()
    if focussedElement == 'AXTextField' then
      -- hs.eventtap.keyStroke('cmd', 'a')
      hs.eventtap.keyStrokes('javascript:()')
      hs.eventtap.keyStroke({}, "return")
    else
      hs.eventtap.keyStroke('cmd', 'l', 200000, currentApplication)
    end
  end
end

hs.hotkey.bind('cmd', 'l', chromeToggleSearchBar)

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
