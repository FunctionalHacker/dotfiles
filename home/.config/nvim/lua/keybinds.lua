local map = vim.keymap.set

-- Telescope
--map('n', '<C-f>', '<cmd>Telescope find_files find_command=fd,-Ht,f<CR>')
--map('n', '<C-g>', '<cmd>Telescope live_grep<CR>')

-- Navigate between buffers
map('n', '<C-N>', vim.cmd.bn, {silent = true})
map('n', '<C-B>', vim.cmd.bp, {silent = true})

-- Navigate between splits
map('n', '<C-H>', '<C-W><C-H>')
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')

-- Run Neoformat
map('n', '<M-f>', vim.cmd.Neoformat)

-- Exit terminal insert mode with esc
map('t', '<Esc>', '<C-\\><C-n>')
