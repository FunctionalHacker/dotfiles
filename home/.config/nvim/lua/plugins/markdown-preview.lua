-- Markdown preview
--- @type LazyPluginSpec
return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  config = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
