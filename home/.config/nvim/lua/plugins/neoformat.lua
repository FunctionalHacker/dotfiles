-- Formatter plugin
return {
  "sbdchd/neoformat",
  config = function()
    require("which-key").register({
      f = { "<cmd>Neoformat<CR>", "Format with Neoformat" },
    }, { prefix = "<leader>" })
  end,
}
