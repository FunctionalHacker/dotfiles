-- Package manager for LSP servers, DAP adapters etc.
-- It also handles starting all of my LSP servers
--- @type LazyPluginSpec
return {
  "mason-org/mason.nvim",
  version = "^1.0.0",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
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

    local mlspc = require("mason-lspconfig")
    local lsp_utils = require("lsp_utils")
    local lspconfig = require("lspconfig")

    local commonLspConfigArgs = {
      on_attach = lsp_utils.map_keys,
      capabilities = lsp_utils.get_capabilities(),
    }

    mlspc.setup()
    mlspc.setup_handlers({
      -- Default handler
      function(server_name)
        lspconfig[server_name].setup(commonLspConfigArgs)
      end,

      -- Disable tsserver diagnostics diagnostics
      -- that come from ESLint
      ["ts_ls"] = function()
        lspconfig.ts_ls.setup(vim.tbl_extend("force", commonLspConfigArgs, {
          settings = {
            diagnostics = {
              ignoredCodes = {
                6133, -- Unused variable
                6192, -- Unused import
              },
            },
          },
        }))
      end,

      -- Don't set up jdtls, it is set up by nvim-jdtls
      ["jdtls"] = function() end,

      ["jsonls"] = function()
        lspconfig.jsonls.setup(vim.tbl_extend("force", commonLspConfigArgs, {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        }))
      end,
    })
  end,
}
