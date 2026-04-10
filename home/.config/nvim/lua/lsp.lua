-- Add LSP capabilities
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities({
    -- UFO capabilities
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }, true),
})
