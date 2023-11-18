-- Snippets plugin
return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets collection
  config = function()
    -- load friendly-snippets to luasnip
    require("luasnip/loaders/from_vscode").lazy_load()
  end,
}
