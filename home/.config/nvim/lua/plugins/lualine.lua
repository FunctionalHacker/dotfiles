-- Statusline
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_c = { "navic" },
    },
  },
}
