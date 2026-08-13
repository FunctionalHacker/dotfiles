--- @type LazyPluginSpec
return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},
  keys = {
    {
      "<leader>or",
      function()
        require("overseer").run_task({})
      end,
      desc = "Run",
    },
    {
      "<leader>ot",
      function()
        require("overseer").toggle()
      end,
      desc = "Toggle",
    },
    {
      "<leader>oa",
      function()
        require("overseer.commands").task_action()
      end,
      desc = "Task action",
    },
  },
}
