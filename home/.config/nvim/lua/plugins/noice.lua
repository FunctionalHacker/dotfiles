-- Replace much of neovim's default UI
-- with a modern replacement
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  ---@type NoiceConfig
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      -- add a border to hover docs and signature help
      lsp_doc_border = true,
    },
  },
  keys = {
    {
      desc = "Dismiss notifications",
      "<leader>d",
      "<cmd>NoiceDismiss<cr>",
    },
  },
}
