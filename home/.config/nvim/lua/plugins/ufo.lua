-- Better folds
--- @type LazyPluginSpec
return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  --- @module "ufo"
  --- @type UfoConfig
  opts = {
    close_fold_kinds_for_ft = {
      default = { "imports" },
    },
  },
  init = function()
    -- Remap fold keys to ufo
    local ufo = require("ufo")
    vim.keymap.set("n", "zR", ufo.openAllFolds)
    vim.keymap.set("n", "zM", ufo.closeAllFolds)

    -- Fold settings
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
}
