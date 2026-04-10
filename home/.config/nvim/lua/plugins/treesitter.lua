-- Improved syntax highlighting, text objects and more
--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "MeanderingProgrammer/treesitter-modules.nvim",
    -- Automatically add closing tags for HTML and JSX
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local languages = {
      "bash",
      "css",
      "diff",
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
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "latex",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "query",
      "rasi",
      "regex",
      "rst",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    -- Covers ensure_installed + highlight + indent + fold + incremental selection
    local ts = require("treesitter-modules")
    ts.setup({
      ensure_installed = languages,
      ignore_install = {},
      sync_install = false,
      auto_install = false,

      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      fold = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })

    -- Fold settings
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- autotag
    require("nvim-ts-autotag").setup()

    -- textobjects plugin now uses its own setup + keymaps
    require("nvim-treesitter-textobjects").setup({
      move = {
        set_jumps = false,
      },
      select = {
        lookahead = true,
      },
    })

    -- TODO
    local textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = {
            query = "@function.outer",
            desc = "Select outer part of a function",
          },
          ["if"] = {
            query = "@function.inner",
            desc = "Select inner part of a function",
          },
          ["ac"] = {
            query = "@class.outer",
            desc = "Select outer part of a class",
          },
          ["ic"] = {
            query = "@class.inner",
            desc = "Select inner part of a class",
          },
          ["as"] = {
            query = "@scope",
            query_group = "locals",
            desc = "Select language scope",
          },
        },
      },
    }
  end,
}
