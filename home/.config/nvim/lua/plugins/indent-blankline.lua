-- Indent characters
return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    exclude = {
      filetypes = {
        "",
        "checkhealth",
        "dashboard",
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
