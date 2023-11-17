return function()
  local keymap = vim.keymap
  local o = vim.o
  local ufo = require("ufo")
  ufo.setup({
    close_fold_kinds = {
      "imports",
    },
  })

  -- Using ufo, need to remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  keymap.set("n", "zR", ufo.openAllFolds)
  keymap.set("n", "zM", ufo.closeAllFolds)

  -- Fold settings
  o.foldcolumn = "1"
  o.foldlevel = 99
  o.foldlevelstart = 99
  o.foldenable = true
end
