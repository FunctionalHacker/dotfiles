local fn = vim.fn

-- Install packer if it's not yet installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    print('Installing Packer')
    Packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' ..
                            vim.o.runtimepath
    print('Installed Packer')
end

-- Configure packer
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function()
    local use = require('packer').use

    -- The plugin manager itself
    use {'wbthomason/packer.nvim', opt = true}

    -- Colorscheme
    use({'catppuccin/nvim', as = 'catppuccin'})

    -- Git in signcolumn
    use 'airblade/vim-gitgutter'

    -- Statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Tabline/bufferline
    use {
        'akinsho/nvim-bufferline.lua',
        tag = '*',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Git commands
    use 'tpope/vim-fugitive'

    -- Indent characters
    use 'lukas-reineke/indent-blankline.nvim'

    -- Tree explorer
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'} -- Use fzf for fuzzy finder
    use {'nvim-telescope/telescope-ui-select.nvim'} -- Replace vim built in select with telescope

    -- Do stuff as sudo
    use 'lambdalisue/suda.vim'

    -- Read editorconfig settings
    use 'editorconfig/editorconfig-vim'

    -- Configs for built-in LSP
    use 'neovim/nvim-lspconfig'

    -- Install LSP server executables
    use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"}

    -- Additional LSP features for Java
    use 'mfussenegger/nvim-jdtls'

    -- Display function signature
    use {'ray-x/lsp_signature.nvim'}

    -- Completion
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-path' -- Path source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'rafamadriz/friendly-snippets' -- Snippets collection

    -- treesitter syntax highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }

    -- treesitter plugin for commentstring
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    -- Additional plugins for formats not supported
    -- by treesitter
    use 'jamespeapen/swayconfig.vim'

    -- mappings for commenting in code
    use 'tpope/vim-commentary'

    -- we all know this one
    use 'tpope/vim-surround'

    -- Formatter plugin
    use 'sbdchd/neoformat'

    -- Make editing passwords safer
    use {
        'https://git.zx2c4.com/password-store',
        rtp = 'contrib/vim/redact_pass.vim'
    }

    -- Neovim inside Firefox
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }

    -- Vim <3 Asciidoctor
    use 'habamax/vim-asciidoctor'

end)

-- Sync plugins if Packer was just
-- installed
if Packer_bootstrap then
    print('Syncing plugins')
    require('packer').sync()
    print('Synced')
end

-- Source configurations
require 'plugins/lualine'
require 'plugins/bufferline'
require 'plugins/lsp'
require 'plugins/completion'
require 'plugins/treesitter'
require 'plugins/indent-blankline'
require 'plugins/nvim-tree'
require 'plugins/colorscheme'
require 'plugins/telescope'
