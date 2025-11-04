-- ✨ AI Coding, Vim Style
return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        slash_commands = {
          ["file"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["buffer"] = {
            opts = {
              provider = "snacks",
            },
          },
        },
      },
      inline = { adapter = "copilot" },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Only for authenticating
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
  },
}
