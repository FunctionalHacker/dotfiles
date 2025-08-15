-- Display possible keybinds
--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  config = function()
    -- Add my custom groups
    require("which-key").add({
      { "<leader>", group = "Leader" },
      { "<leader>w", group = "Workspace" },
      { "g", group = "Go to" },
      { "<leader>g", group = "Git" },
      { "<leader>gr", group = "Reset" },
      { "<leader>ga", group = "Add" },
    })
  end,
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
