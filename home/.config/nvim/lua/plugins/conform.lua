local prettier = { "prettierd", "prettier", stop_after_first = true }

-- Formatter plugin
--- @type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = prettier,
      json = prettier,
      python = { "black" },
    },
  },
  keys = {
    {
      desc = "Format with Conform",
      "<leader>f",
      function()
        require("conform").format()
      end,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
