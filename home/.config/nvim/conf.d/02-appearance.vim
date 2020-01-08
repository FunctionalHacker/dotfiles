" Set colorscheme
colorscheme material

" Material theme variant
let g:material_theme_style = 'palenight'

" Enable italics
let g:material_terminal_italics = 1

" Disable built-in statusline because airline shows it
set noshowmode

" Airline
set laststatus=2
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline_theme='material'

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
