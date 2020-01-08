" Set colorscheme
colorscheme material

" Material theme variant
let g:material_theme_style = 'palenight'

" Material theme for lightline
let g:lightline = { 'colorscheme': 'material_vim' }

" Disable built-in statusline because lightline shows it
set noshowmode

" True color support
set termguicolors

" Line numbering
set relativenumber
set number

" Always show signcolumn
set signcolumn=yes

" Autoindent and syntax highlight
set autoindent
set smartindent
syntax on
filetype on
filetype plugin indent on
set tabstop=4
set shiftwidth=4

" Make gutter and cursorline bg transparent
highlight CursorLineNr 			guibg=transparent
highlight SignColumn 			guibg=transparent
