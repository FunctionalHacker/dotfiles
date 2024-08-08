-- Git commands
--- @type LazyPluginSpec
return {
  "tpope/vim-fugitive",
  dependencies = { "borissov/fugitive-gitea" },
  config = function()
    vim.g.fugitive_gitea_domains = {
      "https://git.korhonen.cc",
      "https://git.rossum.fi",
    }
  end,
}
