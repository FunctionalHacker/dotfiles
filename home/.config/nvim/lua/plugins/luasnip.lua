-- Snippet Engine for Neovim
--- @type LazyPluginSpec
return {
  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  -- Snippets collection
  dependencies = { "rafamadriz/friendly-snippets" },
  init = function()
    local vsCodeLoader = require("luasnip/loaders/from_vscode")

    -- Load friendly-snippets
    vsCodeLoader.lazy_load()

    -- Load my custom snippets
    vsCodeLoader.lazy_load({
      paths = { "./snippets" },
    })
  end,
  run = "make install_jsregexp",
  keys = {
    {
      "<C-f>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "i",
    },
    {
      "<C-b>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = "i",
    },
  },
}
