-- Bufferline
--- @type LazyPluginSpec
return {
  "akinsho/bufferline.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  --- @type BufferlineConfig
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
