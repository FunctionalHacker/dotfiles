-- Library of 30+ independent Lua modules improving overall Neovim
return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.files").setup()
  end,
}