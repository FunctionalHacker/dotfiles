-- This module contains lsp related
-- reusable functions
local m = {}

local lsp = vim.lsp
local diagnostic = vim.diagnostic

-- Maps LSP specific keybinds.
-- This makes them only available when LSP is running
function m.map_keys()
  local builtin = require("telescope.builtin")

  require("which-key").add({
    { "<leader>w", group = "Workspace" },
  })

  vim.keymap.set("n", "<leader>F", lsp.buf.format, { desc = "Format with LSP" })
  vim.keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
  vim.keymap.set("n", "<leader>e", diagnostic.open_float, { desc = "Open diagnostics" })
  vim.keymap.set("n", "<leader>k", lsp.buf.signature_help, { desc = "Signature help" })
  vim.keymap.set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>wa", lsp.buf.add_workspace_folder, { desc = "Add folder" })
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, { desc = "List folders" })
  vim.keymap.set("n", "<leader>wr", lsp.buf.remove_workspace_folder, { desc = "Remove folder" })
  vim.keymap.set("n", "K", lsp.buf.hover, { desc = "Hover" })
  vim.keymap.set("n", "[d", diagnostic.goto_prev, { desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", diagnostic.goto_next, { desc = "Next diagnostic" })
  vim.keymap.set("n", "gD", lsp.buf.declaration, { desc = "Declaration" })
  vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definition" })
  vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Implementation" })
  vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })
  vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "Symbols" })
  vim.keymap.set("n", "gt", lsp.buf.type_definition, { desc = "Type definition" })
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
