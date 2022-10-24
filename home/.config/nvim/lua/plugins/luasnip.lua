return function()
    local luasnip = require('luasnip')
    local wk = require('which-key')

    -- load friendly-snippets to luasnip
    require('luasnip/loaders/from_vscode').lazy_load()

    -- Register snippet navigation keybindings
    local snippet_mappings = {
        ['<c-j>'] = {function()luasnip.jump(1) end},
        ['<c-k>'] = {function() luasnip.jump(-1) end}
    }
    --wk.register(snippet_mappings, {mode = "i"})
    --wk.register(snippet_mappings, {mode = "s"})
end
