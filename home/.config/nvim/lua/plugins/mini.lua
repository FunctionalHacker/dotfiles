-- Library of 30+ independent Lua modules improving overall Neovim experience with minimal effort
--- @type LazyPluginSpec
return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.icons").setup()
    require("mini.sessions").setup()

    local icons = require("mini.icons")
    icons.setup()
    icons.mock_nvim_web_devicons()
  end,
}
