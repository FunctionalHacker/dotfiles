--- @type LazyPluginSpec
return {
  "mini.icons",
  config = true,
  event = "VeryLazy",
  init = function()
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
