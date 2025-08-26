-- Bufferline
--- @type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  --- @module "bufferline"
  --- @type bufferline.UserConfig
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}
