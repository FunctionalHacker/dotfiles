require 'common'

-- Open/close tree browser
MapKey('n', '<C-Tab>', '<cmd>NvimTreeToggle<CR>')

-- Telescope
MapKey('n', '<C-f>', '<cmd>Telescope find_files find_command=fd,-Ht,f<CR>')
MapKey('n', '<C-g>', '<cmd>Telescope live_grep<CR>')

-- Completion
-- Navigate completions with tab and shift tab
MapKey('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
MapKey('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- Navigate between buffers
MapKey('n', '<C-N>', ':bn<CR>', {silent = true})
MapKey('n', '<C-B>', ':bp<CR>', {silent = true})

-- Navigate between splits
MapKey('n', '<C-H>', '<C-W><C-H>')
MapKey('n', '<C-J>', '<C-W><C-J>')
MapKey('n', '<C-K>', '<C-W><C-K>')
MapKey('n', '<C-L>', '<C-W><C-L>')

-- FZF
MapKey('n', '<C-f>', 'fzf#vim#complete#path(\'fd\'')

-- Run Neoformat
MapKey('n', '<M-f>', '<cmd>Neoformat<CR>')
