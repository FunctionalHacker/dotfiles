-- Embed Neovim in Chrome, Firefox & others
--- @type LazyPluginSpec
return {
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  init = function()
    vim.g.firenvim_config = {
      localSettings = {
        [".*"] = {
          takeover = "once",
          cmdline = "neovim",
        },
      },
    }
  end,
}
