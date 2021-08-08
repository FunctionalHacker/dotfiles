vim.o.completeopt = 'menuone,noinsert,noselect'

-- Enable for all buffers (for now)
vim.api.nvim_command('autocmd BufEnter * lua require\'completion\'.on_attach()')
