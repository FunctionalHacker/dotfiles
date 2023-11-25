-- Startup dashboard
--- @type LazyPluginSpec
return {
  "goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local theta = require("alpha.themes.theta")
    alpha.setup(theta.config)
  end,
}
