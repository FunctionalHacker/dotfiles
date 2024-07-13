--- @type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  config = true,
  lazy = false,
  keys = {
    {
      "[h",
      function()
        require("gitsigns").prev_hunk()
      end,
      desc = "Previous hunk",
    },
    {
      "]h",
      function()
        require("gitsigns").next_hunk()
      end,
      desc = "Next hunk",
    },
  },
}
