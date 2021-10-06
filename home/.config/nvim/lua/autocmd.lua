local cmd = vim.cmd

-- Remap exit terminal mode to esc
cmd('au TermOpen * tnoremap <buffer> <Esc> <c-\\><c-n>')

-- Fix YAML indentation
cmd('au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab')

-- Run coq.nvim on startup
cmd('au VimEnter * COQnow --shut-up')
