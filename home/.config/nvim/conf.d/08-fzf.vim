" FZF in floating window

autocmd! FileType fzf
autocmd  FileType fzf call SetFZFoptions()
function SetFZFoptions()
	set noshowmode noruler nonumber norelativenumber
	tunmap <buffer> <Esc>
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
	let buf = nvim_create_buf(v:false, v:true)
	call setbufvar(buf, '&signcolumn', 'no')

	let width = float2nr(&columns * 0.8)
	let height = float2nr(&lines * 0.6)
	let horizontal = 1
	let vertical = 1

	let opts = {
				\ 'relative': 'editor',
				\ 'row': (&lines - height) / 2,
				\ 'col': (&columns - width) / 2,
				\ 'width': width,
				\ 'height': height,
				\ 'style': 'minimal'
				\ }

	call nvim_open_win(buf, v:true, opts)
endfunction

" Looks
"let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'

" Keybinds
nmap <C-f> :Files<CR>
nmap <C-g> :Rg<CR>

" Ripgrep command customization
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)
