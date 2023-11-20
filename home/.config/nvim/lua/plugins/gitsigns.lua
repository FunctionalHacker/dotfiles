-- Git status in signcolumn
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()

    require("which-key").register({
      ["["] = { h = { gitsigns.prev_hunk, "Previous hunk" } },
      ["]"] = { h = { gitsigns.next_hunk, "Next hunk" } },
    })
  end,
}
