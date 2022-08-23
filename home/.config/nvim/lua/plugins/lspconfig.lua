-- Pairs of server name and settings.
-- This is iterated through and every
-- server is setup with lspconfig
Servers = {
    html = {},
    jsonls = {},
    lemminx = {},
    marksman = {},
    yamlls = {},
    tsserver = {},
    sumneko_lua = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

M = {}

function M.map_keys(server, bufnr)
    local function map_key(...)
        -- Map to buffer if buffer number is supplied,
        -- globally otherwise
        if bufnr == nil then
            vim.api.nvim_set_keymap(...)
        else
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
    end

    local keymapOpts = {noremap = true, silent = true}
    map_key('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymapOpts)
    map_key('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymapOpts)
    map_key('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymapOpts)
    map_key('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymapOpts)
    map_key('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
            keymapOpts)
    map_key('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
            keymapOpts)
    map_key('n', '<leader>wr',
            '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', keymapOpts)
    map_key('n', '<leader>wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
            keymapOpts)
    map_key('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
            keymapOpts)
    map_key('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymapOpts)
    map_key('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
            keymapOpts)
    map_key('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymapOpts)
    map_key('n', '<leader>e',
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
            keymapOpts)
    map_key('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymapOpts)
    map_key('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymapOpts)
    map_key('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>',
            keymapOpts)
    map_key('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', keymapOpts)
end

function M.setup()

    local function on_attach(server, bufnr)
        -- Setup lsp signature plugin
        require('lsp_signature').setup {}

        -- Setup keybinds
        M.map_keys(server, bufnr)
    end

    -- Setup every defined server
    for server, settings in pairs(Servers) do
        require('lspconfig')[server].setup {
            on_attach = on_attach,
            settings = settings,
            -- Updates capabilities to cmp.nvim and
            -- informs the server about the client capabilities
            capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                           .protocol
                                                                           .make_client_capabilities())
        }
    end
end

return M
