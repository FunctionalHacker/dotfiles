return function()
  require("lualine").setup({
    sections = {
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = { "progress" },
      lualine_c = {
        "navic",
        color_correction = nil,
        navic_opts = nil,
      },
      lualine_z = { "location" },
    },
  })
end
