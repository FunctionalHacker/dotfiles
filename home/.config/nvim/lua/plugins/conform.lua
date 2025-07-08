-- Build the formatters_by_ft table
local formatters_by_ft = {
  lua = { "stylua" },
  python = { "black" },
  toml = { "taplo" },
  sh = { "shfmt" }
}
--
-- Format with prettierd if available, fall back to prettier
local prettierd = { "prettierd", "prettier", stop_after_first = true }
local prettier_fts = {
  "css",
  "html",
  "javascript",
  "json",
  "yaml",
}

-- Add Prettier filetypes
for _, ft in ipairs(prettier_fts) do
  formatters_by_ft[ft] = prettierd
end

-- Formatter plugin
--- @type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = formatters_by_ft,
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
