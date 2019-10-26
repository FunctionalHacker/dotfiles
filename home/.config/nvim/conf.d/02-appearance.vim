" Set colorscheme
colorscheme gruvbox

" Enable italics
let g:gruvbox_italic = 1

" Disable mode indicator because airline shows it
set noshowmode

" True color support
set termguicolors

" Airline
set laststatus=2
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline_theme='gruvbox'

" Line numbering
set number
set relativenumber

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
highlight GitGutterAdd 			guibg=transparent guifg=#b8bb26
highlight GitGutterChange 		guibg=transparent guifg=#8ec07c
highlight GitGutterDelete 		guibg=transparent guifg=#fb4934
highlight GitGutterChangeDelete guibg=transparent guifg=#8ec07c
