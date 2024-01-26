-- This module contains lsp related
-- reusable functions
local m = {}

local lsp = vim.lsp
local diagnostic = vim.diagnostic

-- Maps LSP specific keybinds.
-- This makes them only available when LSP is running
function m.map_keys()
  local builtin = require("telescope.builtin")
  require("which-key").register({
    g = {
      name = "Go to",
      d = { builtin.lsp_definitions, "Definition" },
      D = { lsp.buf.declaration, "Declaration" },
      t = { lsp.buf.type_definition, "Type definition" },
      i = { builtin.lsp_implementations, "Implementation" },
      r = { builtin.lsp_references, "References" },
      s = { builtin.lsp_document_symbols, "Symbols" },
    },
    ["<leader>"] = {
      name = "Leader",
      w = {
        name = "Workspace",
        a = { lsp.buf.add_workspace_folder, "Add folder" },
        r = { lsp.buf.remove_workspace_folder, "Remove folder" },
        l = {
          function()
            print(vim.inspect(lsp.buf.list_workspace_folders()))
          end,
          "List folders",
        },
      },
      k = { lsp.buf.signature_help, "Signature help" },
      rn = { lsp.buf.rename, "Rename symbol" },
      ca = { lsp.buf.code_action, "Code action" },
      e = { diagnostic.open_float, "Open diagnostics" },
      F = { lsp.buf.format, "Format with LSP" },
    },
    K = { lsp.buf.hover, "Hover" },
    ["["] = { d = { diagnostic.goto_prev, "Previous diagnostic" } },
    ["]"] = { d = { diagnostic.goto_next, "Next diagnostic" } },
  })
end

-- Combine built-in LSP and cmp cabaibilities
-- and additional capabilities from other plugins
function m.get_capabilities()
  local capabilities = vim.tbl_deep_extend(
    "force",
    lsp.protocol.make_client_capabilities(),
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
