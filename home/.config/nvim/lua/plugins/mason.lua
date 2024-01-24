-- Package manager for LSP servers, DAP adapters etc.
-- It also handles starting all of my LSP servers
--- @type LazyPluginSpec
return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- Extended functionality for jdtls
    "mfussenegger/nvim-jdtls",
    -- Add support for LSP file operations
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    {
      "folke/neodev.nvim",
      --- @type LuaDevOptions
      opts = {
        override = function(root_dir, library)
          local dotfiles_path = tostring(vim.fn.expand("~/git/dotfiles"))
          if string.find(root_dir, dotfiles_path, 1, true) then
            library.enabled = true
            library.plugins = true
          end
        end,
      },
    },
  },
  config = function()
    require("mason").setup()

    local mason_lsp = require("mason-lspconfig")
    local lsp_utils = require("lsp_utils")
    mason_lsp.setup()

    mason_lsp.setup_handlers({
      -- Default handler
      function(server_name)
        require("lspconfig")[server_name].setup({
          on_attach = lsp_utils.on_attach,
          capabilities = lsp_utils.get_capabilities(),
        })
      end,

      -- Don't set up jdtls, it is set up by nvim-jdtls
      ["jdtls"] = function() end,
    })
  end,
}
