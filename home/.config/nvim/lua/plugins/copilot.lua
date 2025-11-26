-- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
--- @type LazyPluginSpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  dependencies = { "copilotlsp-nvim/copilot-lsp" },
  event = "VeryLazy",
  --- @module "copilot"
  -- @type CopilotConfig
  opts = {
    -- Suggestion and panel are handled by cmp-copilot
    suggestion = { enabled = false },
    panel = { enabled = false },
    nes = {
      enabled = false,
      keymap = {
        accept_and_goto = "<leader>p",
        accept = false,
        dismiss = "<Esc>",
      },
    },
  },
}
