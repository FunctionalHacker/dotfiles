-- Package manager for LSP servers, DAP adapters etc.
return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "mfussenegger/nvim-jdtls",
  },
  config = function()
    require("mason").setup()

    local mason_lsp = require("mason-lspconfig")
    local lsp_utils = require('lsp_utils')
    local capabilities = lsp_utils.get_capabilities()
    mason_lsp.setup()

    mason_lsp.setup_handlers({
      -- Default handler
      function(server_name)
        require("lspconfig")[server_name].setup({
          on_attach = lsp_utils.on_attach,
          capabilities = capabilities,
        })
      end,

      -- Override lua_ls settings
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          on_attach = lsp_utils.on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = { enable = false },
            },
          },
        })
      end,

      -- Don't set up jdtls, it is set up by nvim-jdtls
      ["jdtls"] = function() end,
    })
  end,
}
