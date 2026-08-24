-- ✨ AI Coding, Vim Style
--- @type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "gpt-4.1",
        },
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
          ["symbols"] = {
            opts = {
              provider = "snacks",
            },
          },
          ["help"] = {
            opts = {},
          },
        },
      },
      inline = { adapter = "copilot" },
    },
    display = {
      action_palette = {
        provider = "snacks",
      },
    },
    extensions = {
      spinner = {
        opts = {
          style = "cursor-relative",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "lalitmee/codecompanion-spinners.nvim",
  },
  keys = function()
    local cc = require("codecompanion")
    return {
      {
        "<leader>cmt",
        cc.toggle,
        desc = "Toggle chat",
      },
      {
        "<leader>cmc",
        cc.chat,
        desc = "New chat",
      },
      {
        "<leader>cma",
        cc.actions,
        desc = "Actions",
      },
    }
  end,
}
