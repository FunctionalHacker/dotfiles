-- Display possible keybinds
--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").add({
      { "<leader>", group = "Leader" },
      { "g", group = "Go to" },
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
