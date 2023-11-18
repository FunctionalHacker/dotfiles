-- Git status in signcolumn
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup()

    local wk = require("which-key")
    wk.register({
      ["["] = { h = { gitsigns.prev_hunk, "Previous hunk" } },
      ["]"] = { h = { gitsigns.next_hunk, "Next hunk" } },
    }, { prefix = "<leader>" })

  end,
}
