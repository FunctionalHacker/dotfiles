-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters
--- @type LazyPluginSpec[]
return {
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  -- Automatically fetch schemas from JSON schema store
  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
  },
  -- Add support for LSP file operations
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    opts = {},
  },
  -- Add MasonUpdateAll
  {
    "Zeioth/mason-extra-cmds",
    event = "VeryLazy",
    opts = {},
  },
  -- Add lockfile support
  {
    "zapling/mason-lock.nvim",
    opts = {
      lockfile_path = vim.fn.expand("~/git/dotfiles/home/.config/nvim/mason-lock.json"),
    },
  },
}
