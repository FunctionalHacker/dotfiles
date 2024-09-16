-- Show the current LSP context in winbar
--- @type LazyPluginSpec
return {
  enabled = vim.fn.has("nvim-0.10") == 1,
  "Bekaboo/dropbar.nvim",
}
