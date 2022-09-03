local M = {}

local opts = {mason = {}, lspconfig = {automatic_installation = true}}

M.setup = function() require('mason').setup(opts.mason) end

M.lspconfig_setup =
    function() require('mason-lspconfig').setup(opts.lspconfig) end

return M
