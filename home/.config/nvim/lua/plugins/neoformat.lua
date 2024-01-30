-- Formatter plugin
--- @type LazyPluginSpec
return {
  "sbdchd/neoformat",
  branch = "master",
  keys = {
    {
      desc = "Format with Neoformat",
      "<leader>f",
      "<cmd>Neoformat<cr>",
    },
  },
}
