-- Library of 30+ independent Lua modules improving overall Neovim
--- @type LazyPluginSpec
return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.surround").setup()
    require("mini.comment").setup()
  end,
}
