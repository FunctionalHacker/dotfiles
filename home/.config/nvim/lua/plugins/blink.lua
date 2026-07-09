--- @type LazyPluginSpec
return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        function()
          if vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
            return true
          end
        end,
        "select_next",
        "fallback",
      },

      ["<S-Tab>"] = {
        function()
          if vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
            return true
          end
        end,
        "select_prev",
        "fallback",
      },
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      menu = {
        auto_show = false,
      },
      documentation = {
        auto_show = true,
      },
    },
    sources = {
      default = {
        "snippets",
        "lsp",
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
