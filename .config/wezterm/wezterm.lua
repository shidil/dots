local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { 'fish' }

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12.0
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 144
config.tiling_desktop_environments = {
  "Wayland",
}

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Mocha"
  end
end

local scheme = scheme_for_appearance(wezterm.gui.get_appearance())
local custom = wezterm.color.get_builtin_schemes()[scheme]

config.color_schemes = {
  [scheme] = custom,
}

config.color_scheme = scheme

config.window_decorations = "NONE"
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true


config.window_background_opacity = 0.95 -- Default opacity when not fullscreen
config.macos_window_background_blur = 8

--config.enable_scroll_bar = true
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action { SendString = "\x1b\r" } },
}

--Platform-specific overrides
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.default_prog = { '/Users/shidil/.nix-profile/bin/fish' }
  config.font_size = 15.5
  config.window_decorations = "RESIZE"
end

return config
