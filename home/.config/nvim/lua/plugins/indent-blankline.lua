return function()
  vim.opt.list = true
  require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
  vim.g.indent_blankline_filetype_exclude = {
    "",
    "checkhealth",
    "dashboard",
    "help",
    "lspinfo",
    "man",
    "lazy",
  }
end
