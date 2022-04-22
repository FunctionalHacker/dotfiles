require'nvim-treesitter.configs'.setup {
    highlight = {enable = true},
    indent = {enable = true},
    incremental_selection = {enable = true},
    context_commentstring = {enable = true}
}

vim.wo.foldmethod = 'expr';
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldtext = [[substitute(getline(v:foldstart), '\\t' repeat('\ ',&tabstop),'g').'...'.trim(v:foldend)]]
vim.wo.fillchars = 'fold:\\'
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1
