-- Library of 30+ independent Lua modules improving overall Neovim
--- @type LazyPluginSpec
return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.surround").setup()
    require("mini.comment").setup()

    -- Recommended for which-key
    require("mini.icons").setup()
  end,
}
