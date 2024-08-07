local noice_mode = require("noice").api.statusline.mode
-- Statusline
--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
        {
          noice_mode.get,
          cond = noice_mode.has,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_z = {
        {
          "selectioncount",
          cond = function()
            local mode = vim.fn.mode()
            return mode == "v" or mode == "V" or mode == "\22"
          end,
        },
        {
          "location",
          cond = function()
            local mode = vim.fn.mode()
            return mode ~= "v" and mode ~= "V" and mode ~= "\22"
          end,
        },
      },
    },
  },
  config = true,
}
