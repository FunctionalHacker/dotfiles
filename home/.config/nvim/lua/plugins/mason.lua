local M = {}

Opts = { mason = {}, lspconfig = { automatic_installation = true } }

M.setup = function()
	require("mason").setup(Opts.mason)
end

M.lspconfig_setup = function()
	require("mason-lspconfig").setup(Opts.lspconfig)
end

return M
