--- @type LazyPluginSpec
return {
  "mini.nvim",
  main = "mini.icons",
  event = "VeryLazy",
  opts = {},
  init = function()
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
