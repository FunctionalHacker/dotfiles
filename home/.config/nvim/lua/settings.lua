local o = vim.o
local g = vim.g
o.pumblend = 10

-- Relative line numbers
o.number = true
o.relativenumber = true

-- True colors
o.termguicolors = true

-- Enable cursorline highlighting
o.cursorline = true

-- Floating window transparency
o.winblend = 10

-- Set window title
o.title = true
o.titlestring = "NeoVim: " .. vim.fn.getcwd()

-- Diff settings
o.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"

-- Allow switching buffers with unsaved changes
o.hidden = true

o.guicursor = table.concat({
  "i:ver1", -- Vertical bar cursor in insert mode
  "a:blinkon1", -- Blinking cursor in all modes
}, ",")

-- Enable global statusline
o.laststatus = 3

-- Use suda by default
g.suda_smart_edit = 1

-- Case insensitive search
o.ignorecase = true
o.smartcase = true

-- Set leader
g.mapleader = " "

-- Indentation settings
o.tabstop = 4
o.softtabstop = -1
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true

o.showmode = false
