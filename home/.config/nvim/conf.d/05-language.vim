" LaTex settings
let g:vimtex_view_method='zathura'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:vimtex_compiler_progname='nvr'

" YAML settings
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Run rustfmt on save
let g:rustfmt_autosave = 1
