--- @type LazyPluginSpec
return {
  "snacks.nvim",
  --- @type snacks.Config
  opts = {
    dashboard = {
      preset = {
        keys = {
          {
            icon = "",
            key = "<leader>p",
            desc = "Open a project",
            action = ":lua Snacks.dashboard.pick('projects')",
          },
          {
            icon = "",
            key = "<leader><leader>",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('smart')",
          },
          { icon = "", key = "<leader>/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "", key = "e", desc = "New File", action = ":ene | startinsert" },
          { icon = "", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "", key = "m", desc = "Mason", action = ":Mason" },
          {
            icon = "",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.expand('~/git/dotfiles/home/.config/nvim/lua')})",
          },
          { icon = "", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗    ██╗   ██╗██╗███╗   ███╗
██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║    ██║   ██║██║████╗ ████║
█████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║    ██║   ██║██║██╔████╔██║
██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║    ╚██╗ ██╔╝██║██║╚██╔╝██║
██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝ ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                                                                        ]],
      },
    },
  },
}
