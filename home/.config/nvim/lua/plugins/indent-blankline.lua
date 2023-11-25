-- Indent characters
--- @type LazyPluginSpec
return {
  "lukas-reineke/indent-blankline.nvim",
  --- @type ibl.config
  opts = {
    exclude = {
      filetypes = {
        "",
        "checkhealth",
        "alpha",
        "git",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "help",
        "lazy",
        "lspinfo",
        "man",
      },
    },
  },
  main = "ibl",
}
