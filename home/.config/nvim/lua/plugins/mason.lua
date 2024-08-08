-- Package manager for LSP servers, DAP adapters etc.
-- It also handles starting all of my LSP servers
--- @type LazyPluginSpec
return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
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
  },
  config = function()
    require("mason").setup()

    local mlspc = require("mason-lspconfig")
    local lsp_utils = require("lsp_utils")

    local commonLspConfigArgs = {
      on_attach = lsp_utils.map_keys,
      capabilities = lsp_utils.get_capabilities(),
    }

    mlspc.setup()
    mlspc.setup_handlers({
      -- Default handler
      function(server_name)
        require("lspconfig")[server_name].setup(commonLspConfigArgs)
      end,

      -- Disable tsserver diagnostics diagnostics
      -- that come from ESLint
      ["tsserver"] = function()
        require("lspconfig").tsserver.setup(vim.tbl_extend("force", commonLspConfigArgs, {
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
    })
  end,
}
