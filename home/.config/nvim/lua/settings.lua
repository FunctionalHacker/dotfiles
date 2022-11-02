local o = vim.o
local g = vim.g

-- True colors
o.termguicolors = true

-- Font for nvim GUI's
o.guifont = "Fira Code:h14"

-- Hide mouse when typing in neovide
g.neovide_hide_mouse_when_typing = true

-- Enable cursor particles in neovide
g.neovide_cursor_vfx_mode = 'railgun'

-- Floating window transparency
o.winblend = 10

-- Set window title
o.title = true
o.titlestring = "NeoVim: " .. vim.fn.getcwd()

-- Diff settings
o.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"

-- Allow switching buffers with unsaved changes
o.hidden = true

-- Show line numbers
o.number = true

o.guicursor = table.concat({
	"i:ver1", -- Vertical bar cursor in insert mode
	"a:blinkon1", -- Blinking cursor in all modes
}, ",")

-- Enable global statusline
o.laststatus = 3

o.cmdheight = 1

-- Use suda by default
g.suda_smart_edit = 1

-- Case insensitive search
o.ignorecase = true
o.smartcase = true

-- Set leader
g.mapleader = " "

-- Indentation settings
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
