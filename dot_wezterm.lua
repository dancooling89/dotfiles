local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

-- Configure the title bar
config.enable_tab_bar = false

-- Configure window padding
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

return config
