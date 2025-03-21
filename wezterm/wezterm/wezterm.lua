local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono", { weight = "Thin", italic = true })
config.font_size = 14
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7
config.macos_window_background_blur = 0
config.prefer_egl = true
config.window_padding = {
	left = 5,
	right = 0,
	top = 10,
	bottom = 0,
}
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.color_scheme = "GruvboxDarkHard"

return config
