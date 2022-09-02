local map = vim.keymap.set

-- Navigate between buffers
map('n', '<C-N>', vim.cmd.bn, {silent = true})
map('n', '<C-B>', vim.cmd.bp, {silent = true})

-- Run Neoformat
map('n', '<M-f>', vim.cmd.Neoformat, {})

-- Exit terminal insert mode with esc
map('t', '<Esc>', '<C-\\><C-n>', {})
