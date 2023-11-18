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
    pickers = {
      find_files = { find_command = { "fd", "-Ht", "f" } },
      lsp_references = { show_line = false },
      live_grep = {
        additional_args = function(opts)
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
  config = function(spec)
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup(spec.opts)

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("cder")

    -- Keybinds
    vim.keymap.set("n", "<C-s>", vim.cmd.Telescope)
    vim.keymap.set("n", "<C-f>", builtin.find_files)
    vim.keymap.set("n", "<C-g>", builtin.live_grep)
  end,
}
