local nvim_local_dir = vim.fn.expand('~/.local/share/nvim')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = nvim_local_dir .. '/jdtls-workspaces/' .. project_name

require('jdtls').start_or_attach({
    cmd = {
        'java', '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true', '-Dlog.level=ALL', '-Xms1g',
        '--add-modules=ALL-SYSTEM', '--add-opens',
        'java.base/java.util=ALL-UNNAMED', '--add-opens',
        'java.base/java.lang=ALL-UNNAMED', '-jar', nvim_local_dir ..
            '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', nvim_local_dir .. '/mason/packages/jdtls/config_linux',
        '-data', workspace_dir
    }
})

require('plugins.lsp').lsp_map_keys('jdtls', nil)
