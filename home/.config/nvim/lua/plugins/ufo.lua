-- Better folds
-- Disabled for now because it causes weird artifacts
return {
  enabled = false,
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    close_fold_kinds = {
      "imports",
    },
  },
  config = function(spec)
    local ufo = require("ufo")
    ufo.setup(spec.opts)

    -- Using ufo, need to remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    local keymap = vim.keymap
    keymap.set("n", "zR", ufo.openAllFolds)
    keymap.set("n", "zM", ufo.closeAllFolds)

    -- Fold settings
    local o = vim.o
    o.foldcolumn = "1"
    o.foldlevel = 99
    o.foldlevelstart = 99
    o.foldenable = true
  end,
}
