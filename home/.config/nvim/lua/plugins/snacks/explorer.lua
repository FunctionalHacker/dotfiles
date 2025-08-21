--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {},
    picker = {
      sources = {
        explorer = {},
      },
    },
  },
  keys = {
    {
      "<leader>o",
      function()
        Snacks.explorer()
      end,
      desc = "Open/close file explorer",
    },
  },
}
