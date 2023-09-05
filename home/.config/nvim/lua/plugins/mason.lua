local m = {}

function m.setup()
  local function on_attach()
    -- Setup lsp signature plugin
    require("lsp_signature").setup({})

    -- Setup keybinds
    m.map_keys()
  end

  -- Inform lsp about completion capabilities from cmp
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  require("mason").setup()
  local mason_lsp = require("mason-lspconfig")
  mason_lsp.setup()

  mason_lsp.setup_handlers({
    -- Default handler
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- Override lua_ls settings
    ["lua_ls"] = function()
      require("lspconfig").lua_ls.setup({
        on_attach = on_attach,
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
end

function m.map_keys()
  require("which-key").register({
    g = {
      name = "Go to",
      d = { vim.lsp.buf.definition, "Definition" },
      D = { vim.lsp.buf.declaration, "Declaration" },
      i = { vim.lsp.buf.implementation, "Implementation" },
      r = { vim.lsp.buf.references, "References" },
    },
    ["<leader>"] = {
      name = "Leader",
      w = {
        name = "Workspace",
        a = { vim.lsp.buf.add_workspace_folder, "Add folder" },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove folder" },
        l = {
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          "List folders",
        },
      },
      k = { vim.lsp.buf.signature_help, "Signature help" },
      D = { vim.lsp.buf.type_definition, "Type definition" },
      rn = { vim.lsp.buf.rename, "Rename symbol" },
      ca = { vim.lsp.buf.code_action, "Code action" },
      e = { vim.diagnostic.open_float, "Open diagnostics" },
      F = { vim.lsp.buf.format, "Format with LSP" },
    },
    K = { vim.lsp.buf.hover, "Hover" },
    ["["] = { d = { vim.diagnostic.goto_prev, "Previous diagnostic" } },
    ["]"] = { d = { vim.diagnostic.goto_next, "Next diagnostic" } },
  })
end

return m
