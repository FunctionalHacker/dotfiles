-- Customize statuscolumn
--- @type LazyPluginSpec
return {
  "luukvbaal/statuscol.nvim",
  dependencies = {
    {
      "lewis6991/gitsigns.nvim",
      config = true,
    },
  },
  config = function()
    local gitsigns = require("gitsigns")
    require("which-key").register({
      ["["] = { h = { gitsigns.prev_hunk, "Previous hunk" } },
      ["]"] = { h = { gitsigns.next_hunk, "Next hunk" } },
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
