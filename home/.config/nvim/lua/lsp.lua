local lsp = vim.lsp

-- Add capabilities
vim.lsp.config("*", {
  capabilities = vim.tbl_deep_extend(
    "force",
    -- Default capabilities
    lsp.protocol.make_client_capabilities(),
    -- Capabilities of cmp
    require("cmp_nvim_lsp").default_capabilities(),
    -- Neovim hasn't added foldingRange to default capabilities, we must add it manually for ufo
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
