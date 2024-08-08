local k = vim.keymap.set

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
    k("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
    k("n", "]h", gs.next_hunk, { desc = "Next hunk" })

    -- Hunk actions
    opts = { desc = "Hunk" }
    k("n", "<leader>grh", gs.reset_hunk, opts)
    k("n", "<leader>gah", gs.stage_hunk, opts)

    -- Buffer actions
    opts = { desc = "Buffer" }
    k("n", "<leader>gab", gs.stage_buffer, opts)
    k("n", "<leader>grb", gs.reset_buffer, opts)
  end,
}
