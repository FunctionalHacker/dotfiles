local k = function(lhs, rhs, opts)
  vim.keymap.set("", lhs, rhs, opts)
end

--- @type LazyPluginSpec
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local gs = require("gitsigns")
    gs.setup()

    -- Add groups for which-key
    require("which-key").add({
      { "<leader>g", group = "Git" },
      { "<leader>gr", group = "Reset" },
      { "<leader>ga", group = "Add" },
    })

    -- Keybinds
    local opts

    -- Hunk navigation
    k("[h", gs.prev_hunk, { desc = "Previous hunk" })
    k("[h", gs.next_hunk, { desc = "Next hunk" })

    -- Hunk actions
    opts = { desc = "Hunk" }
    k("<leader>grh", gs.reset_hunk, opts)
    k("<leader>gah", gs.stage_hunk, opts)

    -- Buffer actions
    opts = { desc = "Buffer" }
    k("<leader>gab", gs.stage_buffer, opts)
    k("<leader>grb", gs.reset_buffer, opts)
  end,
}
