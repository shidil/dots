local wezterm = require("wezterm")
local projects = require 'projects'
local appearance = require 'appearance'

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
config.hide_tab_bar_if_only_one_tab = false

config.pane_focus_follows_mouse = true

config.window_background_opacity = 0.95 -- Default opacity when not fullscreen
config.macos_window_background_blur = 8

--config.enable_scroll_bar = true
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()

--Platform-specific overrides
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.default_prog = { '/Users/shidil/.nix-profile/bin/fish' }
  config.font_size = 15.5
  config.window_decorations = "RESIZE"
end

config.leader = {
  key = 'Space',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 }
  }
end


config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action { SendString = "\x1b\r" } },
  {
    key = 'Space',
    -- When we're in leader mode _and_ CTRL + Space is pressed...
    mods = 'LEADER|CTRL',
    -- Actually send CTRL + Space key to the terminal
    action = wezterm.action.SendKey { key = 'Space', mods = 'CTRL' },
  },
  -- Open Wezterm config in Neovim
  {
    key = ';',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { 'nvim', wezterm.config_file },
    },
  },
  -- Rename tab
  {
    key = ',',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  -- Rename workspace
  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            wezterm.mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  -- Create new vertical split
  {
    key = 'e',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical {
      domain = "CurrentPaneDomain"
    },
  },
  -- Create new horizontal split
  {
    key = 'E',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal {
      domain = "CurrentPaneDomain"
    },
  },
  -- Close current pane
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane {
      confirm = false
    },
  },
  -- Pane resize mode
  {
    -- When we push LEADER + R...
    key = 'r',
    mods = 'LEADER',
    -- Activate the `resize_panes` keytable
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      -- Ensures the keytable stays active after it handles its
      -- first keypress.
      one_shot = false,
      -- Deactivate the keytable after a timeout.
      timeout_milliseconds = 1000,
    }
  },
  -- Pane navigation
  move_pane('j', 'Down'),
  move_pane('k', 'Up'),
  move_pane('h', 'Left'),
  move_pane('l', 'Right'),
  move_pane(';', 'Prev'),
  move_pane('\'', 'Prev'),
  -- Swap pane
  {
    key = '\\',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect { mode = 'SwapWithActiveKeepFocus' }
  },
  -- Workspace/Project switch
  {
    key = 'p',
    mods = 'LEADER',
    -- Present in to our project picker
    action = projects.choose_project(),
  },
  {
    key = 'f',
    mods = 'LEADER',
    -- Present a list of existing workspaces
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
  },
}

config.key_tables = {
  resize_panes = {
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('h', 'Left'),
    resize_pane('l', 'Right'),
  },
}

config.ssh_domains = {
  {
    name = 'oolio',
    remote_address = 'ooliovm',
    username = 'oolio',
    default_prog = { 'fish' },
    assume_shell = 'Posix',
  },
  {
    name = 'agents',
    remote_address = 'agentsvm',
    username = 'work',
    default_prog = { 'fish' }
  },
  {
    name = 'wolfden',
    remote_address = 'wolfden',
    username = 'shidil',
    default_prog = { 'fish' }
  },
}

config.unix_domains = {
  {
    name = "unix",
  },
  {
    name = "wpoolio",
    proxy_command = { "waypipe", "--xwls", "ssh", "-t", "oolio", "~/.nix-profile/bin/wezterm", "cli", "proxy" },
  }
}

config.default_gui_startup_args = { 'connect', 'unix' }

local function segments_for_right_status(window)
  return {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M'),
    wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  -- Each powerline segment is going to be coloured progressively
  -- darker/lighter depending on whether we're on a dark/light color scheme
  ---@diagnostic disable-next-line: unbalanced-assignments
  local gradient_to, gradient_from = bg
  if appearance.is_dark() then
    gradient_from = gradient_to:lighten(0.1)
  else
    gradient_from = gradient_to:darken(0.2)
  end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colours as we have segments.
  )

  -- We'll build up the elements to send to wezterm.format in this table.
  local elements = {}

  for i, seg in ipairs(segments) do
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
