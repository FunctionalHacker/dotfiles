return function()
	require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		renderer = {
			highlight_git = true
		}
	}
	-- Open/close with alt-o
	vim.keymap.set('n', '<M-o>', vim.cmd.NvimTreeToggle)
end
