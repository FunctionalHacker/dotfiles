-- Indent characters
return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("ibl").setup({
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
    })
  end,
}
