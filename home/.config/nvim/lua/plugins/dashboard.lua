return function()
  require("dashboard").setup({
    theme = "hyper",
    config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        { icon = "🧲 ", desc = "Update", group = "@property", action = "Lazy update", key = "u" },
        {
          icon = "🖹 ",
          icon_hl = "@variable",
          desc = "Files",
          group = "Label",
          action = "Telescope find_files",
          key = "f",
        },
        { icon = "❌ ", desc = "Quit", action = "q", key = "q" },
      },
    },
  })
end
