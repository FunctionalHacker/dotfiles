return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "css",
      "dockerfile",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "json5",
      "latex",
      "lua",
      "make",
      "markdown",
      "php",
      "python",
      "rasi",
      "regex",
      "rst",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
    context_commentstring = { enable = true },
    sync_install = true,
    ignore_install = {},
    auto_install = true,
  })

  -- vim.wo.foldmethod = 'expr'
  -- im.wo.foldexpr = 'nvim_treesitter#foldexpr()'
end
