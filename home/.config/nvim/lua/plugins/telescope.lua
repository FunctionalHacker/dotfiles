--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    -- Internal dependency for telescope
    "nvim-lua/plenary.nvim",

    -- Use fzf for fuzzy finder
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    -- Replace vim built in select with telescope
    "nvim-telescope/telescope-ui-select.nvim",

    -- cd plugin for telescope
    "zane-/cder.nvim",
  },
  opts = {
    -- Set layout to vertical
    defaults = {
      layout_strategy = "flex",
      layout_config = {
        flex = {
          flip_columns = 200,
        },
      },
    },
    pickers = {
      find_files = { find_command = { "fd", "-Ht", "f" } },
      lsp_references = { show_line = false },
      live_grep = {
        additional_args = function()
          return { "--hidden" }
        end,
      },
    },
    extensions = {
      cder = {
        previewer_command = "eza "
          .. "-a "
          .. "--color=always "
          .. "-T "
          .. "--level=3 "
          .. "--icons "
          .. "--git-ignore "
          .. "--long "
          .. "--no-permissions "
          .. "--no-user "
          .. "--no-filesize "
          .. "--git "
          .. "--ignore-glob=.git",
        dir_command = { "fd", "-Ht", "d", ".", os.getenv("HOME") },
      },
    },
  },
  keys = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local extensions = telescope.extensions

    return {
      {
        desc = "Open Telescope",
        "t",
        function()
          builtin.builtin({ include_extensions = true })
        end,
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("cder")
    telescope.load_extension("notify")
  end,
}
