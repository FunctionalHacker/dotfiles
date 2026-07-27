-- Colorscheme
--- @type LazyPluginSpec
return {
  "rebelot/kanagawa.nvim",
  dependencies = {
    { "f-person/auto-dark-mode.nvim", opts = {} },
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
        PmenuSel = { fg = "none", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },

        -- Better looks for git-blame.nvim virtual text
        GitBlameVirtualText = {
          fg = theme.syn.comment,
          bg = theme.ui.bg_p2,
        },

        SnacksDashboardHeader = { fg = theme.vcs.removed },
        SnacksDashboardFooter = { fg = theme.syn.comment },
        SnacksDashboardDesc = { fg = theme.syn.identifier },
        SnacksDashboardIcon = { fg = theme.ui.special },
        SnacksDashboardKey = { fg = theme.syn.special1 },
        SnacksDashboardSpecial = { fg = theme.syn.comment },
        SnacksDashboardDir = { fg = theme.syn.identifier },
        SnacksNotifierBorderError = { link = "DiagnosticError" },
        SnacksNotifierBorderWarn = { link = "DiagnosticWarn" },
        SnacksNotifierBorderInfo = { link = "DiagnosticInfo" },
        SnacksNotifierBorderDebug = { link = "Debug" },
        SnacksNotifierBorderTrace = { link = "Comment" },
        SnacksNotifierIconError = { link = "DiagnosticError" },
        SnacksNotifierIconWarn = { link = "DiagnosticWarn" },
        SnacksNotifierIconInfo = { link = "DiagnosticInfo" },
        SnacksNotifierIconDebug = { link = "Debug" },
        SnacksNotifierIconTrace = { link = "Comment" },
        SnacksNotifierTitleError = { link = "DiagnosticError" },
        SnacksNotifierTitleWarn = { link = "DiagnosticWarn" },
        SnacksNotifierTitleInfo = { link = "DiagnosticInfo" },
        SnacksNotifierTitleDebug = { link = "Debug" },
        SnacksNotifierTitleTrace = { link = "Comment" },
        SnacksNotifierError = { link = "DiagnosticError" },
        SnacksNotifierWarn = { link = "DiagnosticWarn" },
        SnacksNotifierInfo = { link = "DiagnosticInfo" },
        SnacksNotifierDebug = { link = "Debug" },
        SnacksNotifierTrace = { link = "Comment" },
        SnacksProfilerIconInfo = { bg = theme.ui.bg_search, fg = theme.syn.fun },
        SnacksProfilerBadgeInfo = { bg = theme.ui.bg_visual, fg = theme.syn.fun },
        SnacksScratchKey = { link = "SnacksProfilerIconInfo" },
        SnacksScratchDesc = { link = "SnacksProfilerBadgeInfo" },
        SnacksProfilerIconTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
        SnacksProfilerBadgeTrace = { bg = theme.syn.fun, fg = theme.ui.float.fg_border },
        SnacksIndent = { fg = theme.ui.bg_p2, nocombine = true },
        SnacksIndentScope = { fg = theme.ui.pmenu.bg, nocombine = true },
        SnacksZenIcon = { fg = theme.syn.statement },
        SnacksInputIcon = { fg = theme.ui.pmenu.bg },
        SnacksInputBorder = { fg = theme.syn.identifier },
        SnacksInputTitle = { fg = theme.syn.identifier },
        SnacksPickerInputBorder = { fg = theme.syn.constant },
        SnacksPickerInputTitle = { fg = theme.syn.constant },
        SnacksPickerBoxTitle = { fg = theme.syn.constant },
        SnacksPickerSelected = { fg = theme.syn.number },
        SnacksPickerToggle = { link = "SnacksProfilerBadgeInfo" },
        SnacksPickerPickWinCurrent = { fg = theme.ui.fg, bg = theme.syn.number, bold = true },
        SnacksPickerPickWin = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
      }
    end,
  },
  init = function()
    vim.cmd("colorscheme kanagawa")
  end,
}
