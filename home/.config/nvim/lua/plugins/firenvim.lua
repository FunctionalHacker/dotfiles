-- Neovim inside Firefox
return {
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  config = function()
    vim.g.firenvim_config = {
      localSettings = {
        [".*"] = {
          takeOver = "never",
        },
      },
    }
  end,
}
