---@diagnostic disable: assign-type-mismatch

---@type Wezterm
local wezterm = require("wezterm")
---@type Config
local config = wezterm.config_builder()

---@type table<string, Palette>
local custom_color_schemes = {
  ["Kanagawa Lotus"] = {
    foreground = "#545464",
    background = "#f2ecbc",

    cursor_bg = "#43436c",
    cursor_fg = "#43436c",
    cursor_border = "#43436c",

    selection_fg = "#43436c",
    selection_bg = "#9fb5c9",

    scrollbar_thumb = "#b5cbd2",
    split = "#b5cbd2",

    ansi = {
      "#1F1F28",
      "#c84053",
      "#6f894e",
      "#77713f",
      "#4d699b",
      "#b35b79",
      "#597b75",
      "#545464",
    },

    brights = {
      "#8a8980",
      "#d7474b",
      "#6e915f",
      "#836f4a",
      "#6693bf",
      "#624c83",
      "#5e857a",
      "#43436c",
    },

    indexed = {
      [16] = "#e98a00",
      [17] = "#e82424",
    },

    tab_bar = {
      background = "#e4d794",

      active_tab = {
        bg_color = "#b35b79",
        fg_color = "#e4d794",
      },

      inactive_tab = {
        bg_color = "#a6a69c",
        fg_color = "#e4d794",
      },

      inactive_tab_hover = {
        bg_color = "#9fb5c9",
        fg_color = "#43436c",
        italic = true,
      },

      new_tab = {
        bg_color = "#8a8980",
        fg_color = "#e4d794",
      },

      new_tab_hover = {
        bg_color = "#9fb5c9",
        fg_color = "#43436c",
        italic = true,
      },
    },
  },
}

local light_scheme = "Kanagawa Lotus"
local dark_scheme = "Kanagawa (Gogh)"

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

local function get_scheme()
  if get_appearance():find("Dark") then
    return dark_scheme
  else
    return light_scheme
  end
end

config.color_schemes = custom_color_schemes
config.color_scheme = get_scheme()

return config
