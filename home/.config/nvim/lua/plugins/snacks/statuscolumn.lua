--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    statuscolumn = {
      folds = {
        open = true,
        git_hl = true,
      },
    },
  },
}
