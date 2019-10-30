" Auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif             

" Set coc extensions
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-highlight',
  \ 'coc-vimtex',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-emmet'
  \ ]

call plug#begin()

" Make editing passwords safer
Plug 'https://git.zx2c4.com/password-store', { 'rtp': 'contrib/vim/redact_pass.vim' }

" Spelling
Plug 'vim-scripts/Vimchant'

" Pandoc plugins
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" This is so I can use vim as a diff pager
Plug 'powerman/vim-plugin-AnsiEsc'

" Airline statusline
Plug 'vim-airline/vim-airline'

" Syntax plugins
Plug 'stephpy/vim-yaml'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'kevinoid/vim-jsonc'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'zplugin/zplugin-vim-syntax'
Plug 'aouelete/sway-vim-syntax'

" Read editorconfig settings
Plug 'editorconfig/editorconfig-vim'

" Make directory if it doesn't exist
Plug 'pbrisbin/vim-mkdir'

" Tree explorer
Plug 'scrooloose/nerdtree'

" Moar snippets
Plug 'honza/vim-snippets'

" Filetype icons
Plug 'ryanoasis/vim-devicons'

" A personal wiki for vim
Plug 'vimwiki/vimwiki'

" Surround stuff with brackets and quotes 
Plug 'tpope/vim-surround'

" Do stuff as sudo
Plug 'lambdalisue/suda.vim'

" Conguer of Completion
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

" Git wrapper
Plug 'tpope/vim-fugitive'

" Git diff in gutter
Plug 'airblade/vim-gitgutter'

" Gpg support
Plug 'jamessan/vim-gnupg'

" Colorscheme
Plug 'morhetz/gruvbox'

" Latex plugin
Plug 'lervag/vimtex'

call plug#end()
