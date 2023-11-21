return {
  "luukvbaal/statuscol.nvim",
  dependencies = {
    {
      "lewis6991/gitsigns.nvim",
      opts = {},
    },
  },
  config = function()
    local gitsigns = require("gitsigns")
    require("which-key").register({
      ["["] = { c = { gitsigns.prev_hunk, "Previous hunk" } },
      ["]"] = { c = { gitsigns.next_hunk, "Next hunk" } },
    })

    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { "%s" }, click = "v:lua.ScSa" },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
      },
    })
  end,
}
