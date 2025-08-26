-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters
--- @type LazyPluginSpec
return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", config = true },
    "neovim/nvim-lspconfig",
    -- Add support for LSP file operations
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Add MasonUpdateAll
    { "Zeioth/mason-extra-cmds", config = true },
    -- Add lockfile support
    {
      "zapling/mason-lock.nvim",
      opts = {
        lockfile_path = vim.fn.expand("~/git/dotfiles/home/.config/nvim/mason-lock.json"),
      },
    },
    -- Extended functionality for jdtls
    "mfussenegger/nvim-jdtls",
    -- Automatically fetch schemas from JSON schema store
    "b0o/schemastore.nvim",
  },
}
