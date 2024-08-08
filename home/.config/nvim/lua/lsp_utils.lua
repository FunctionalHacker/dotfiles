-- This module contains lsp related
-- reusable functions
local m = {}

local lsp = vim.lsp
local diagnostic = vim.diagnostic
local k = vim.keymap.set

-- Maps LSP specific keybinds.
-- This makes them only available when LSP is running
function m.map_keys()
  local builtin = require("telescope.builtin")

  require("which-key").add({
    { "<leader>w", group = "Workspace" },
  })

  k("n", "<leader>F", lsp.buf.format, { desc = "Format with LSP" })
  k("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
  k("n", "<leader>e", diagnostic.open_float, { desc = "Open diagnostics" })
  k("n", "<leader>k", lsp.buf.signature_help, { desc = "Signature help" })
  k("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symbol" })
  k("n", "<leader>wa", lsp.buf.add_workspace_folder, { desc = "Add folder" })
  k("n", "<leader>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, { desc = "List folders" })
  k("n", "<leader>wr", lsp.buf.remove_workspace_folder, { desc = "Remove folder" })
  k("n", "K", lsp.buf.hover, { desc = "Hover" })
  k("n", "[d", diagnostic.goto_prev, { desc = "Previous diagnostic" })
  k("n", "]d", diagnostic.goto_next, { desc = "Next diagnostic" })
  k("n", "gD", lsp.buf.declaration, { desc = "Declaration" })
  k("n", "gd", builtin.lsp_definitions, { desc = "Definition" })
  k("n", "gi", builtin.lsp_implementations, { desc = "Implementation" })
  k("n", "gr", builtin.lsp_references, { desc = "References" })
  k("n", "gs", builtin.lsp_document_symbols, { desc = "Symbols" })
  k("n", "gt", lsp.buf.type_definition, { desc = "Type definition" })
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
