local o = vim.o
local g = vim.g

-- True colors
o.termguicolors = true

-- Floating window transparency
o.winblend = 10

-- Diff settings
o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'

-- Allow switching buffers with unsaved changes
o.hidden = true

-- Show line numbers
o.number = true

-- Blinking cursor
o.guicursor = 'a:blinkon1'

-- Enable global statusline
o.laststatus = 3

-- Hide cmdline
o.cmdheight = 0

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
