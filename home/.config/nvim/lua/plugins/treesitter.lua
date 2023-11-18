return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
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
        "markdown_inline",
        "php",
        "python",
        "rasi",
        "regex",
        "rst",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "vim",
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
  end,
}
