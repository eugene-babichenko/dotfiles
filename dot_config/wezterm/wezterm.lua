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

config.status_update_interval = 1000

local act = wezterm.action
config.keys = {
  {
    key = "p",
    mods = "SUPER",
    action = act.PaneSelect({}),
  },
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
  -- Open the default editor
  {
    key = "e",
    mods = "SUPER",
    action = act.SendString("$EDITOR\n"),
  },
  -- Move tab right
  {
    key = "RightArrow",
    mods = "SUPER|ALT",
    action = act.MoveTabRelative(1),
  },
  -- Move tab left
  {
    key = "LeftArrow",
    mods = "SUPER|ALT",
    action = act.MoveTabRelative(-1),
  },
}

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

-- Press Super+Arrow to open a new pane in the direction of arrow
for _, direction in pairs({ "Up", "Down", "Left", "Right" }) do
  table.insert(config.keys, {
    key = string.format("%sArrow", direction),
    mods = "SUPER",
    action = act.SplitPane({ direction = direction }),
  })
end

local ACTIVE_TITLEBAR_BG = "#333333"

-- status bar for full screen operation
wezterm.on("update-right-status", function(window, _)
  local nerd = wezterm.nerdfonts
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local elems = {}

  local battery = wezterm.battery_info()[1]
  local battery_bg = config.window_frame.ACTIVE_TITLEBAR_BG

  if battery ~= nil then
    local BATTERY_ICONS = {
      Charging = { icon = nerd.md_battery_charging, color = "#b8bb26" },
      Discharging = { icon = nerd.md_battery_50, color = "#fabd2f" },
      Empty = { icon = nerd.md_battery_outline, color = "#fb4934" },
      -- full indicates the battery is charged and the device is using external power
      Full = { icon = nerd.md_battery_charging, color = "#b8bb26" },
      Unknown = { icon = nerd.md_battery_unknown, color = "#cc241d" },
    }

    local icon = BATTERY_ICONS[battery.state]
    battery_bg = icon.color

    local percentage = math.floor(battery.state_of_charge * 100)

    table.insert(elems, { Foreground = { Color = battery_bg } })
    table.insert(elems, { Background = { Color = ACTIVE_TITLEBAR_BG } })
    table.insert(elems, { Text = SOLID_LEFT_ARROW })
    table.insert(elems, { Foreground = { Color = ACTIVE_TITLEBAR_BG } })
    table.insert(elems, { Background = { Color = battery_bg } })
    table.insert(
      elems,
      { Text = string.format(" %s %d%% ", icon.icon, percentage) }
    )
  end

  local CLOCK_COLOR = "#ebdbb2"
  table.insert(elems, { Background = { Color = battery_bg } })
  table.insert(elems, { Foreground = { Color = CLOCK_COLOR } })
  table.insert(elems, { Text = SOLID_LEFT_ARROW })
  table.insert(elems, { Background = { Color = CLOCK_COLOR } })
  table.insert(elems, { Foreground = { Color = ACTIVE_TITLEBAR_BG } })
  table.insert(elems, { Text = " " })
  table.insert(elems, { Text = nerd.md_clock })
  table.insert(elems, { Text = wezterm.strftime("  %a %b %-d %H:%M ") })

  window:set_right_status(wezterm.format(elems))
end)

return config
