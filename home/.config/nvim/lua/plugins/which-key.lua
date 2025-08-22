-- Display possible keybinds
--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  --- @module "which-key"
  --- @type wk.Opts
  opts = {
    spec = {
      { "g", group = "Go to" },
      { "<leader>", group = "Leader" },
      { "<leader>w", group = "Workspace" },
      { "<leader>d", group = "Dismiss" },
      { "<leader>f", group = "Find" },
      { "<leader>s", group = "Search" },
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>gr", group = "Reset" },
      { "<leader>ga", group = "Add" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
