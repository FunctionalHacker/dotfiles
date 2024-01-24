-- Confirm before quit
--- @type LazyPluginSpec
return {
  enabled = vim.g.neovide == not nil,
  "yutkat/confirm-quit.nvim",
  event = "CmdlineEnter",
  opts = {
    quit_message = "You are in Neovide, are you sure you want to quit?",
  },
}
