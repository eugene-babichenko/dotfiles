local wezterm = require("wezterm")

local config = wezterm.config_builder()
config:set_strict_mode(true)

local font = "IosevkaTerm Nerd Font"

config.font = wezterm.font(font)
config.font_size = 14

config.color_scheme = "Gruvbox Dark (Gogh)"

config.initial_cols = 120
config.initial_rows = 36

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_frame = {
  font = wezterm.font({ family = font, weight = "Bold" }),
  font_size = 13,
}

config.max_fps = 60

config.enable_kitty_graphics = true

local act = wezterm.action
config.keys = {
  { key = "p", mods = "SUPER", action = act.PaneSelect({}) },
  {
    key = "UpArrow",
    mods = "SHIFT",
    action = wezterm.action.ScrollToPrompt(-1),
  },
  {
    key = "DownArrow",
    mods = "SHIFT",
    action = wezterm.action.ScrollToPrompt(1),
  },
  -- Open config in the default system editor with Cmd+, (the Apple way)
  {
    key = ",",
    mods = "SUPER",
    domain = { DomainName = "local" },
    action = act.SpawnCommandInNewTab({
      cwd = os.getenv("WEZTERM_CONFIG_DIR"),
      args = { os.getenv("SHELL"), "-c", "$EDITOR $WEZTERM_CONFIG_FILE" },
    }),
  },
  -- Move tab right
  { key = "RightArrow", mods = "SUPER|ALT", action = act.MoveTabRelative(1) },
  -- Move tab left
  { key = "LeftArrow", mods = "SUPER|ALT", action = act.MoveTabRelative(-1) },
}

-- Press Super+Arrow to open a new pane in the direction of arrow
-- Press Alt+Arrow to resize a pane
for _, direction in pairs({ "Up", "Down", "Left", "Right" }) do
  local key = string.format("%sArrow", direction)
  table.insert(config.keys, {
    key = key,
    mods = "SUPER",
    action = act.SplitPane({ direction = direction }),
  })
  table.insert(config.keys, {
    key = key,
    mods = "ALT",
    action = act.AdjustPaneSize({ direction, 5 }),
  })
end

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("PrimarySelection"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SUPER",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 2, button = "Left" } },
    action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
    mods = "ALT",
  },
}

return config
