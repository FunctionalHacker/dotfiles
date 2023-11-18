return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "kyazdani42/nvim-web-devicons" },
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
