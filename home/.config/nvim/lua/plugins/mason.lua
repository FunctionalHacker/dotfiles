-- Package manager for LSP servers, DAP adapters etc.
-- It also handles starting all of my LSP servers
--- @type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  dependencies = {
    { "mason-org/mason-lspconfig.nvim" },
    "neovim/nvim-lspconfig",
    -- Add MasonUpdateAll
    { "Zeioth/mason-extra-cmds", opts = {} },
    -- Add lockfile support
    {
      "zapling/mason-lock.nvim",
      opts = {
        lockfile_path = vim.fn.expand("~/git/dotfiles/home/.config/nvim/mason-lock.json"),
      },
    },
    -- Extended functionality for jdtls
    "mfussenegger/nvim-jdtls",
    -- Add support for LSP file operations
    { "antosha417/nvim-lsp-file-operations", opts = {} },
    -- Automatically fetch schemas from JSON schema store
    "b0o/schemastore.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    local lsp_utils = require("lsp_utils")

    -- Default settings for all LSP servers
    vim.lsp.config("*", {
      on_attach = lsp_utils.map_keys,
      capabilities = lsp_utils.get_capabilities(),
    })

    -- Add schemastore for JSON LSP
    vim.lsp.config.jsonls.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    }
  end,
}
