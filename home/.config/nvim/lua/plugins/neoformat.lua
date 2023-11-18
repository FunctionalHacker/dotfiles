-- Formatter plugin
return {
  "sbdchd/neoformat",
  config = function()
    local wk = require("which-key")
    wk.register({
      f = { "<cmd>Neoformat<CR>", "Format with Neoformat" },
    }, { prefix = "<leader>" })
  end,
}
