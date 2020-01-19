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
			\ 'coc-texlab',
			\ 'coc-prettier',
			\ 'coc-python',
			\ 'coc-emmet',
			\ 'coc-rust-analyzer',
			\ 'coc-markdownlint',
			\ 'coc-snippets',
			\ ]

call plug#begin()

" statusline/tabline
Plug 'vim-airline/vim-airline'

" Make editing passwords safer
Plug 'https://git.zx2c4.com/password-store', { 'rtp': 'contrib/vim/redact_pass.vim' }

" Colorize color words
Plug 'norcalli/nvim-colorizer.lua'

" Use neovim from firefox
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Spelling
Plug 'vim-scripts/Vimchant'

" Pandoc plugins
Plug 'vim-pandoc/vim-pandoc'
Plug 'conornewton/vim-pandoc-markdown-preview'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Language syntax pack
Plug 'sheerun/vim-polyglot'

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

" Surround stuff with brackets and quotes 
Plug 'tpope/vim-surround'

" Do stuff as sudo
Plug 'lambdalisue/suda.vim'

" Conguer of Completion
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

" VimL source for CoC
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'

" Git plugin
Plug 'jreybert/vimagit'

" Git diff in gutter
Plug 'airblade/vim-gitgutter'

" Gpg support
Plug 'jamessan/vim-gnupg'

" Colorscheme
Plug 'joshdick/onedark.vim'

" Latex plugin
Plug 'lervag/vimtex'

call plug#end()
