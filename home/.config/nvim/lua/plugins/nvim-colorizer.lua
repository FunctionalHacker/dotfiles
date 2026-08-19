---@diagnostic disable: missing-fields

-- High performance color highlighter
--- @type LazyPluginSpec
return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  ---@module 'colorizer'
  ---@type colorizer.NewOptions
  opts = {
    parsers = {
      rgb = { enable = true },
    },
  },
}
