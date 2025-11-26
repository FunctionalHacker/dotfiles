local noice = require("noice").api.status

-- Statusline
--- @type LazyPluginSpec
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    sections = {
      lualine_b = {
        {
          function()
            local project = vim.g.current_snacks_project or vim.fn.getcwd()
            return vim.fn.fnamemodify(project, ":t")
          end,
        },
        "branch",
      },
      lualine_x = {
        {
          noice.command.get,
          cond = noice.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          noice.mode.get,
          cond = noice.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          noice.search.get,
          cond = noice.search.has,
          color = { fg = "#ff9e64" },
        },
        "filetype",
        "encoding",
        "fileformat",
      },
      lualine_z = {
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
}
