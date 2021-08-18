local o = vim.o
local g = vim.g
local cmd = vim.cmd

------ Appearance ------

-- Set colorscheme
require('onedark').setup()

-- True colors
o.termguicolors = true

-- Floating window transparency
o.winblend = 10

-- Remove extra line
o.cmdheight = 1

-- Always show signcolumn
o.signcolumn = 'yes'

-- Diff settings
cmd 'set diffopt=filler,internal,algorithm:histogram,indent-heuristic'

-- Show line numbers
cmd 'set number'

-- Blinking cursor
cmd 'set guicursor=i:ver1'
cmd 'set guicursor+=a:blinkon1'

-- Gutter and cursoline bg transparent
cmd 'highlight CursorLineNr guibg=transparent'
cmd 'highlight SignColumn guibg=transparent'

------ Misc -------

-- Use suda by default
g.suda_smart_edit = 1


-- Split direction
o.splitbelow = true
o.splitright = true


-- Case insensitive search
o.ignorecase = true
o.smartcase = true

-- Use mouse
o.mouse = 'a'

-- Use system clipboard
o.clipboard = 'unnamedplus'

-- Autoindent and syntax higlight
o.autoindent = true
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4
cmd 'syntax on'
cmd 'filetype on'
cmd 'filetype plugin indent on'

-- Disable auto commenting
o.formatoptions = 'cro'
