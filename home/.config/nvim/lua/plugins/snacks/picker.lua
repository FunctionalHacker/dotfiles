--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      hidden = true,
      sources = {
        files = {
          hidden = true,
        },
      },
    },
  },
  keys = {
    {
      "<C-f>",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<C-g>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep files",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.projects()
      end,
      desc = "Open a project",
    },
  },
}
