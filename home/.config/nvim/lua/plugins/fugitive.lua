-- Git commands
--- @type LazyPluginSpec
return {
  "tpope/vim-fugitive",
  keys = {
    {
      "<leader>gs",
      function()
        vim.cmd("Git status")
      end,
      desc = "Status",
    },
    {
      "<leader>gaa",
      function()
        vim.cmd("Git add -A")
      end,
      desc = "All",
    },
    {
      "<leader>gc",
      function()
        vim.cmd("Git commit")
      end,
      desc = "Commit",
    },
    {
      "<leader>gP",
      function()
        vim.cmd("Git push")
      end,
      desc = "Push",
    },
    {
      "<leader>gp",
      function()
        vim.cmd("Git pull")
      end,
      desc = "Pull",
    },
  },
}
