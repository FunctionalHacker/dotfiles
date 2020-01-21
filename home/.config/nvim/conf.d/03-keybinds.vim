" Change leader to space
nnoremap <SPACE> <Nop>
let mapleader = ' '

" Toggle nerdtree
map <silent> <C-t> :NERDTreeToggle<CR>

" Markdown preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

set splitbelow
set splitright

" Move between buffers
nnoremap <C-N> :bn<CR>
nnoremap <C-B> :bp<CR>

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable mouse
set mouse=a

" Toggle equalalways
function ToggleEqual ()
	:set equalalways!
	:set equalalways!
endfunction

nnoremap <leader>= :call ToggleEqual()<CR>
