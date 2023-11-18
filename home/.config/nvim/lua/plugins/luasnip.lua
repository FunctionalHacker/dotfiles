-- Snippets plugin
return {
  "L3MON4D3/LuaSnip",
  -- Snippets collection
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    -- load friendly-snippets to luasnip
    require("luasnip/loaders/from_vscode").lazy_load()
  end,
}
