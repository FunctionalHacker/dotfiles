--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
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

    -- Switch to a project
    {
      "ahmedkhalf/project.nvim",
      main = "project_nvim",
      opts = {
        patterns = { ".git" },
      },
    },
  },
  opts = {
    -- Set layout to vertical
    defaults = {
      layout_strategy = "vertical",
      layout_defaults = {
        vertical = {
          preview_height = 0.5,
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
  keys = {
    {
      desc = "Open Telescope",
      "<C-s>",
      "<cmd>Telescope<cr>",
    },
    {
      desc = "Change directories",
      "cd",
      "<cmd>Telescope cder<cr>",
    },
    {
      desc = "Find files",
      "<C-f>",
      "<cmd>Telescope find_files<cr>",
    },
    {
      desc = "Grep files",
      "<C-g>",
      "<cmd>Telescope live_grep<cr>",
    },
    {
      desc = "Change to a project",
      "<C-p>",
      "<cmd>Telescope projects<cr>",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("cder")
    telescope.load_extension("projects")
  end,
}
