-- Auto completion
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
    "petertriho/cmp-git", -- Git source
    -- Copilot source
    {
      "zbirenbaum/copilot-cmp",
      opts = { fix_pairs = true },
    },
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = "menuone,noselect"

    local bordered = cmp.config.window.bordered()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = bordered,
        documentation = bordered,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        -- Snippet placeholder forward
        ["<C-f>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Snippet placeholder backward
        ["<C-b>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Completion menu forward
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- If only one entry, select it
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),
        -- Completion menu backward
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
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
        {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
      },
    })

    require("cmp_git").setup()

    -- Enable autopairs when enter is processed
    -- on completion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- search cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
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
