-- Replace much of neovim's default UI
-- with a modern replacement
--- @type LazyPluginSpec
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  --- @module "noice"
  --- @type NoiceConfig
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
      desc = "Notifications",
      "<leader>dn",
      function()
        vim.cmd("NoiceDismiss")
      end,
    },
  },
}
