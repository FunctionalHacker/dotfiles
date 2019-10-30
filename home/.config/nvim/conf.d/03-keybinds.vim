" Change leader to space
nnoremap <SPACE> <Nop>
let mapleader = ' '

" Toggle nerdtree
map <silent> <C-t> :NERDTreeToggle<CR>

" Markdown preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" FZF
nmap <C-f> :Files<CR>
nmap <C-g> :Rg<CR>
" Ripgrep command customization
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

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

" Preview with pandoc
nnoremap <leader>v :PandocPreview<cr>
