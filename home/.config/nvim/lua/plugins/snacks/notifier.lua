--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    notifier = {},
  },
  keys = {
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
    {
      "<leader>dn",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Notifications",
    },
  },
}
