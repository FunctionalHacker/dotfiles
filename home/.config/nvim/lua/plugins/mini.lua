-- Library of 30+ independent Lua modules improving overall Neovim experience with minimal effort

local function setup(mod)
  require("mini." .. mod).setup()
end

--- @type LazyPluginSpec
return {
  "nvim-mini/mini.nvim",
  event = "VeryLazy",
  init = function()
    setup("move")
    setup("surround")
    setup("icons")
    setup("comment")
    setup("sessions")
  end,
}
