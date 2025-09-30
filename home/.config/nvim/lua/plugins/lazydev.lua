-- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
--- @type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  dependencies = {
    { "DrKJeff16/wezterm-types", lazy = true },
  },
  --- @module "lazydev"
  --- @type lazydev.Config
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
      { path = "lazy.nvim", words = { "LazyPluginSpec" } },
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
