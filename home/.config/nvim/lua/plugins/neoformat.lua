-- Formatter plugin
--- @type LazyPluginSpec
return {
  "sbdchd/neoformat",
  keys = {
    {
      desc = "Format with Neoformat",
      "<leader>f",
      "<cmd>Neoformat<cr>",
    },
  },
}
