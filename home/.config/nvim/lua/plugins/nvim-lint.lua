--- @type LazyPluginSpec
return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  keys = {
    {
      "<leader>cl",
      function()
        require("lint").try_lint()
      end,
      desc = "Run linter",
    },
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      html = { "htmlhint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
