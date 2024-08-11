-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Ibm 3270 (High Contrast) (Gogh)'
-- config.color_scheme = 'Dotshare (terminal.sexy)'
-- config.color_scheme = 'X::DotShare (terminal.sexy)'
config.color_scheme = 'Tomorrow Night Bright (Gogh)'

config.hide_tab_bar_if_only_one_tab = true
config.font_size = 16.0


config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe',
  -- 'yazi'
  'btop',
}

config.window_padding = {
  left = 0,
  right = 0,
  top = 1,
  bottom = 1,
}

-- and finally, return the configuration to wezterm
return config

