return function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'bash', 'c', 'css', 'dockerfile', 'html', 'http', 'java', 'json',
            'json5', 'latex', 'lua', 'make', 'markdown', 'php', 'python',
            'regex', 'rst', 'scss', 'toml', 'tsx', 'typescript', 'javascript',
            'yaml'
        },
        highlight = {enable = true},
        indent = {enable = true},
        incremental_selection = {enable = true},
        context_commentstring = {enable = true}
    }

    -- vim.wo.foldmethod = 'expr'
    -- im.wo.foldexpr = 'nvim_treesitter#foldexpr()'
end
