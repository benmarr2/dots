local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.default_prog = { "/usr/bin/bash", "-l", "-i"}
config.color_scheme = 'GruvboxDarkHard'
config.window_background_opacity = 0.95

config.keys = {
  {key="W", mods="CTRL|SHIFT", action=wezterm.action.DisableDefaultAssignment},
  {key="W", mods="CTRL|SHIFT", action=wezterm.action.SendString("\x00X")},
  {key="Backspace", mods="CTRL|SHIFT", action=wezterm.action.SendString("\x00\"")},
  {key="Enter", mods="CTRL|SHIFT", action=wezterm.action.SendString("\x00%")},
}

return config
