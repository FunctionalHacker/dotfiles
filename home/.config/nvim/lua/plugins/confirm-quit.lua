-- Confirm before quit
--- @type LazyPluginSpec
return {
  enabled = vim.g.neovide == not nil,
  "yutkat/confirm-quit.nvim",
  event = "CmdlineEnter",
  config = true,
}
