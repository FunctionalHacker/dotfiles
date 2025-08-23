-- Colorscheme
--- @type LazyPluginSpec
return {
  "rebelot/kanagawa.nvim",
  dependencies = {
    { "f-person/auto-dark-mode.nvim", config = true },
  },
  --- @module "kanagawa"
  --- @type KanagawaConfig
  opts = {
    compile = true,
    dimInactive = true,
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none", -- Hide gutter background
          },
        },
      },
    },
    background = {
      dark = "wave",
      light = "lotus",
    },
    overrides = function(colors)
      local theme = colors.theme
      return {
        -- Transparent floating windows
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        -- More uniform look for the popup menu
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  init = function()
    vim.cmd("colorscheme kanagawa")
  end,
}
