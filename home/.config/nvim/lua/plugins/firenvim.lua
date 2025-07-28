-- Neovim inside Firefox
--- @type LazyPluginSpec
return {
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  config = function()
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
