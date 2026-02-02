local wezterm = require 'wezterm'

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Mocha'
  else
    return 'Catppuccin Latte'
  end
end

return {
  -- font = wezterm.font('Hack Nerd Font'),
  font_size = 13.0,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  default_cursor_style = 'SteadyUnderline',

  enable_tab_bar = false,

  hide_mouse_cursor_when_typing = true,

  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

  keys = {
    { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(8) },
  },
}
