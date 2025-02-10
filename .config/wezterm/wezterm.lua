local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { 'fish' }

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12.0
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

function scheme_for_appearance(appearance)
	if appearance:find "Dark" then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Mocha"
	end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.window_background_opacity = 0.95 -- Default opacity when not fullscreen
config.macos_window_background_blur = 8

--config.enable_scroll_bar = true
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()

return config
