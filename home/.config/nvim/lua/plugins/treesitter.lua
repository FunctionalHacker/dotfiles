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

    -- Text objects
    require("nvim-treesitter-textobjects").setup({
      move = {
        set_jumps = false,
      },
      select = {
        lookahead = true,
      },
    })

    local move = require("nvim-treesitter-textobjects.move")
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      move.goto_next_start("@function.outer")
    end, { desc = "Next function start" })
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      move.goto_next_end("@function.outer")
    end, { desc = "Next function end" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      move.goto_previous_start("@function.outer")
    end, { desc = "Prev function start" })
    vim.keymap.set({ "n", "x", "o" }, "[F", function()
      move.goto_previous_end("@function.outer")
    end, { desc = "Prev function end" })
    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      move.goto_next_start("@class.outer")
    end, { desc = "Next class start" })
    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      move.goto_next_end("@class.outer")
    end, { desc = "Next class end" })
    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      move.goto_previous_start("@class.outer")
    end, { desc = "Prev class start" })
    vim.keymap.set({ "n", "x", "o" }, "[C", function()
      move.goto_previous_end("@class.outer")
    end, { desc = "Prev class end" })

    local select = require("nvim-treesitter-textobjects.select")
    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer")
    end, { desc = "Select outer part of a function" })
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner")
    end, { desc = "Select inner part of a function" })
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer")
    end, { desc = "Select outer part of a class" })
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner")
    end, { desc = "Select inner part of a class" })
    vim.keymap.set({ "x", "o" }, "as", function()
      select.select_textobject("@scope", "locals")
    end, { desc = "Select language scope" })
  end,
}
