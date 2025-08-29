-- Library of 30+ independent Lua modules improving overall Neovim experience with minimal effort
--- @type LazyPluginSpec
return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  import = "plugins.mini",
}
