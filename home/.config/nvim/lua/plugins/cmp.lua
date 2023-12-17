-- Autoompletion
--- @type LazyPluginSpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer", -- Buffer source
    -- Git source
    {
      "petertriho/cmp-git",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = true,
    },
    "hrsh7th/cmp-nvim-lsp", -- LSP source
    "hrsh7th/cmp-nvim-lua", -- Neovim Lua API documentation source
    "hrsh7th/cmp-path", -- Path source
    "hrsh7th/cmp-cmdline", -- cmdline source
    "saadparwaiz1/cmp_luasnip", -- Snippets source
    "f3fora/cmp-spell", -- Spell check source
    -- Copilot source
    {
      "zbirenbaum/copilot-cmp",
      opts = { fix_pairs = true },
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = "menuone,noselect"

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "git" },
        { name = "copilot" },
        { name = "buffer" },
        { name = "spell" },
        { name = "path" },
      },
    })

    -- Enable autopairs when enter is processed
    -- on completion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
}
