local lsp_installer = require("nvim-lsp-installer")

Lsp_map_keys = function(server, bufnr)
    print("Lsp_map_keys()")
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
    map_key('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
            keymapOpts)
    map_key('n', '<space>wr',
            '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', keymapOpts)
    map_key('n', '<space>wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
            keymapOpts)
    map_key('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
            keymapOpts)
    map_key('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymapOpts)
    map_key('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
            keymapOpts)
    map_key('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymapOpts)
    map_key('n', '<space>e',
            '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
            keymapOpts)
    map_key('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymapOpts)
    map_key('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymapOpts)
    map_key('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>',
            keymapOpts)
    map_key('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', keymapOpts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
    -- Don't setup jdtls here since it is done by nvim-jdtls
    if server.name == "jdtls" then return end

    local opts = {}

    -- Lua specific settings
    if server.name == "sumneko_lua" then
        local runtime_path = vim.split(package.path, ';')
        opts.settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'}
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true)
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {enable = false}
            }
        }
    end

    opts.on_attach = Lsp_map_keys
    opts.capabilities = capabilities
    server:setup(opts)
end)
