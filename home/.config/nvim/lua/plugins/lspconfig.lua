-- Pairs of server name and settings.
-- This is iterated through and every
-- server is setup with lspconfig
local servers = {
	bashls = {},
	html = {},
	jsonls = {},
	lemminx = {},
	marksman = {},
	yamlls = {},
	taplo = {},
	tsserver = {},
  rust_analyzer = {},
	lua_ls = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
}

local m = {}

function m.map_keys()
	-- Register keybindings via which-key
	-- to get documentation in which-key
	local wk = require("which-key")
	wk.register({
		g = {
			name = "Go to",
			d = { vim.lsp.buf.definition, "Definition" },
			D = { vim.lsp.buf.declaration, "Declaration" },
			i = { vim.lsp.buf.implementation, "Implementation" },
			r = { vim.lsp.buf.references, "References" },
		},
		["<leader>"] = {
			name = "Leader",
			w = {
				name = "Workspace",
				a = { vim.lsp.buf.add_workspace_folder, "Add folder" },
				r = { vim.lsp.buf.remove_workspace_folder, "Remove folder" },
				l = {
					function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end,
					"List folders",
				},
			},
			D = { vim.lsp.buf.type_definition, "Type definition" },
			rn = { vim.lsp.buf.rename, "Rename symbol" },
			ca = { vim.lsp.buf.code_action, "Code action" },
			e = { vim.diagnostic.open_float, "Open diagnostics" },
			f = { vim.lsp.buf.format, "Format" },
		},
		K = { vim.lsp.buf.hover, "Hover" },
		["["] = { d = { vim.diagnostic.goto_prev, "Previous diagnostic" } },
		["]"] = { d = { vim.diagnostic.goto_next, "Next diagnostic" } },
	})
end

function m.setup()
	local function on_attach()
		-- Setup lsp signature plugin
		require("lsp_signature").setup({})

		-- Setup keybinds
		m.map_keys()
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Setup every defined server
	for server, settings in pairs(servers) do
		require("lspconfig")[server].setup({
			on_attach = on_attach,
			settings = settings,
			-- Inform lsp server about client
			-- capabilities
			capabilities = capabilities,
		})
	end
end

return m
