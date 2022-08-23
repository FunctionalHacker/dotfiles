local M = {}

function lsp_map_keys(server, bufnr)
	print('lsp_map_keys')
	local function map_key(...)
		-- Map to buffer if buffer number is supplied,
		-- globally otherwise
		if bufnr == nil then
			vim.api.nvim_set_keymap(...)
		else
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
	end

	local keymapOpts = { noremap = true, silent = true }
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
	map_key('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', keymapOpts)
end

M.on_attach = function(server, bufnr)
	print('on_attach')
	-- Setup lsp signature plugin
	require('lsp_signature').setup {}

	-- Setup keybinds
	lsp_map_keys(server, bufnr)
end


function M.setup()
	local lspconfig = require('lspconfig')

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Common settings for all servers
	local lsp_defaults = {
		on_attach = M.on_attach, -- Common on_attach
		capabilities = capabilities -- Add additional capabilities supported by nvim-cmp
	}

	-- Set default config for all servers
	--lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)

	-- Register capabilities to cmp.nvim
	--require('cmp_nvim_lsp').update_capabilities(capabilities)

	-- LSP servers setup
	--lspconfig.tsserver.setup {}
	--lspconfig.yamlls.setup {}
	--lspconfig.jsonls.setup {}
	--lspconfig.html.setup {}
	--lspconfig.marksman.setup {}

	--lspconfig.sumneko_lua.setup {
	--	settings = {
	--		Lua = {
	--			runtime = {
	--				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
	--				version = 'LuaJIT',
	--				-- Setup your lua path
	--				path = vim.split(package.path, ';')
	--			},
	--			diagnostics = {
	--				-- Get the language server to recognize the `vim` global
	--				globals = { 'vim' }
	--			},
	--			workspace = {
	--				-- Make the server aware of Neovim runtime files
	--				library = vim.api.nvim_get_runtime_file('', true)
	--			},
	--			-- Do not send telemetry data containing a randomized but unique identifier
	--			telemetry = { enable = false }
	--		}
	--	}
	--}
end

return M
