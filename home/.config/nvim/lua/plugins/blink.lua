return {
  "saghen/blink.cmp",
  version = "1.*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "enter" },
    completion = {
      ghost_text = {
        enabled = true,
      },
      menu = {
        auto_show = false,
      },
      documentation = {
        auto_show = false,
      },
    },
    snippets = { preset = "luasnip" },
    sources = {
      default = {
        "lsp",
        "snippets",
        "path",
        "buffer",
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    appearance = {
      nerd_font_variant = "mono",
    },
  },
  opts_extend = { "sources.default" },
}
