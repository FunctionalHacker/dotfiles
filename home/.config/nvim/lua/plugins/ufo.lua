-- Better folds
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  opts = {
    close_fold_kinds = {
      "imports",
    },
  },
  config = function(_, opts)
    local ufo = require("ufo")
    ufo.setup(opts)

    -- Using ufo, we need to remap `zR` and `zM`
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)

    -- Fold settings
    local o = vim.o
    o.foldcolumn = "0"
    o.foldlevel = 99
    o.foldlevelstart = 99
    o.foldenable = true
  end,
}
