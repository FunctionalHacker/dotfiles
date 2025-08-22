-- Add LSP capabilities
vim.lsp.config("*", {
  capabilities = vim.tbl_deep_extend(
    "force",
    -- Default capabilities
    vim.lsp.protocol.make_client_capabilities(),
    -- Capabilities of cmp
    require("cmp_nvim_lsp").default_capabilities(),
    -- UFO capabilities
    {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }
  ),
})
