-- This module contains lsp related
-- reusable functions
local m = {}

-- Maps LSP specific keybinds.
-- This makes them only available when LSP is running
local function map_keys()
  local telescope_builtin = require("telescope.builtin")
  require("which-key").register({
    g = {
      name = "Go to",
      d = { telescope_builtin.lsp_definitions, "Definition" },
      D = { vim.lsp.buf.declaration, "Declaration" },
      i = { telescope_builtin.lsp_implementations, "Implementation" },
      r = { telescope_builtin.lsp_references, "References" },
      s = { telescope_builtin.lsp_document_symbols, "Symbols" },
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

-- Maps keys and does other needed actions
-- when client attaches
function m.on_attach(client, bufnr)
  -- Attach navic if document symbols are available
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  -- Setup keybinds
  map_keys()
end

-- Combine built-in LSP and cmp cabaibilities
-- and additional capabilities from other plugins
function m.get_capabilities()
  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  -- Neovim hasn't added foldingRange to default capabilities, users must add it manually for ufo
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

return m
