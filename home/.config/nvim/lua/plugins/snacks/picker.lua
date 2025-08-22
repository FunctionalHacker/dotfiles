--- @type LazyPluginSpec
return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      hidden = true,
      sources = {
        files = {
          hidden = true,
        },
      },
    },
  },
  keys = {
    {
      "<leader>s",
      function()
        Snacks.picker()
      end,
      desc = "Open Snacks",
    },
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<C-g>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep files",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.projects()
      end,
      desc = "Open a project",
    },
    -- LSP keybinds
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Definition",
    },
    {
      "gi",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Implementation",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      desc = "References",
    },
    {
      "gs",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Symbols",
    },
  },
}
