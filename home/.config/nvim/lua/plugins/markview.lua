-- A hackable markdown, Typst, latex, html(inline) & YAML previewer for Neovim
return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
    },
  },
}
