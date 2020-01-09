" FZF in floating window

autocmd! FileType fzf
autocmd  FileType fzf call SetFZFoptions()
function SetFZFoptions()
	set noshowmode noruler nonumber norelativenumber
	tunmap <buffer> <Esc>
endfunction

set winblend=20

hi NormalFloat guibg=None
if exists('g:fzf_colors.bg')
	call remove(g:fzf_colors, 'bg')
endif

if stridx($FZF_DEFAULT_OPTS, '--border') == -1
	let $FZF_DEFAULT_OPTS .= ' --border'
endif

function! FloatingFZF()
	let width = float2nr(&columns * 0.8)
	let height = float2nr(&lines * 0.6)
	let opts = { 'relative': 'editor',
				\ 'row': (&lines - height) / 2,
				\ 'col': (&columns - width) / 2,
				\ 'width': width,
				\ 'height': height }

	call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Keybinds
nmap <C-f> :Files<CR>
nmap <C-g> :Rg<CR>

" Files command customization
command! -bang -nargs=* Rg
			\ call fzf#vim#files(
			\   'rg --files --hidden 2>/dev/null'.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

" Ripgrep command customization
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --hidden --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)
