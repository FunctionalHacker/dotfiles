-- Improved syntax highlighting, text objects and more
--- @type LazyPluginSpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  --- @module "nvim-treesitter"
  --- @type TSConfig
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
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
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
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
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
  },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        --- @type table<string,fun(...)>
        local move = require("nvim-treesitter.textobjects.move")
        local configs = require("nvim-treesitter.configs")
        for name, fn in pairs(move) do
          if name:find("goto") == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                --- @type table<string,string>
                local config = configs.get_module("textobjects.move")[name]
                for key, query in pairs(config or {}) do
                  if q == query and key:find("[%]%[][cC]") then
                    vim.cmd("normal! " .. key)
                    return
                  end
                end
              end
              return fn(q, ...)
            end
          end
        end
      end,
    },
    -- Automatically add closing tags for HTML and JSX
    {
      "windwp/nvim-ts-autotag",
      config = true,
    },
  },
}
