-- Startup dashboard
--- @type LazyPluginSpec
return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    theme = "hyper",
    config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        {
          icon = "🧲 ",
          desc = "Update",
          group = "@property",
          action = "Lazy update",
          key = "u",
        },
      },
      project = {
        enable = true,
        limit = 8,
        label = "Projects",
        action = function(path)
          -- "Telescope find_files cwd="
          require("telescope.builtin").find_files({ cwd = path })
        end,
      },
    },
  },
}
