--- @type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  config = true,
  keys = function()
    local gs = require("gitsigns")

    return {
      -- Hunk navigation
      {
        "[h",
        function()
          gs.nav_hunk("prev")
        end,
        desc = "Previous hunk",
      },

      {
        "]h",
        function()
          gs.nav_hunk("next")
        end,
        desc = "Next hunk",
      },

      -- Hunk actions
      {
        "<leader>gah",
        function()
          gs.stage_hunk()
        end,
        desc = "Buffer",
      },
      {
        "<leader>grh",
        function()
          gs.reset_hunk()
        end,
        desc = "Buffer",
      },

      -- Buffer actions
      {
        "<leader>gab",
        function()
          gs.stage_buffer()
        end,
        desc = "Buffer",
      },
      {
        "<leader>grb",
        function()
          gs.reset_buffer()
        end,
        desc = "Buffer",
      },
    }
  end,
}
