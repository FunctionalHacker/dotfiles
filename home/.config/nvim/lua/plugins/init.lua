local fn = vim.fn

-- Install packer if it's not yet installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    print('Installing Packer')
    Packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd [[packadd packer.nvim]]
    print('Installed Packer')
end

-- Configure packer
require('packer').startup(function()
    local use = require('packer').use

    -- The plugin manager itself
    use {'wbthomason/packer.nvim'}

    -- Colorscheme
    use {
        'rebelot/kanagawa.nvim',
        config = function() vim.cmd('colorscheme kanagawa') end
    }

    -- Statusline
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = require('plugins.lualine')
    }

    -- Startup screen/dashboard
    --use 'glepnir/dashboard-nvim'

    -- Git in signcolumn
    use 'airblade/vim-gitgutter'

    -- Tabline/bufferline
    use {
        'akinsho/nvim-bufferline.lua',
        tag = '*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('bufferline').setup {} end
    }

    -- Git commands
    use 'tpope/vim-fugitive'

    -- Indent characters
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.indent-blankline')
    }

    -- Tree explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.nvim-tree')
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        config = require('plugins.telescope'),
        requires = {
            {'nvim-lua/plenary.nvim'}, -- Internal dep for telescope
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, -- Use fzf for fuzzy finder
            {'nvim-telescope/telescope-ui-select.nvim'}, -- Replace vim built in select with telescope
            {'zane-/cder.nvim'}, -- cd plugin for telescope
        }
    }

    -- Do stuff as sudo
    use 'lambdalisue/suda.vim'

    -- Display possible keybinds
    use {'folke/which-key.nvim', config = require('plugins.which-key')}

    -- Read editorconfig settings
    use 'editorconfig/editorconfig-vim'

    -- Package manager for LSP servers, DAP servers etc.
    use {'williamboman/mason.nvim', config = require('plugins.mason').setup}

    -- Install LSP server executables with Mason
    use {
        'williamboman/mason-lspconfig.nvim',
        config = require('plugins.mason').lspconfig_setup
    }

    -- Configs for built-in LSP
    use {'neovim/nvim-lspconfig', config = require('plugins.lspconfig').setup}

    -- Additional LSP features for Java
    use 'mfussenegger/nvim-jdtls'

    -- Display function signature
    use 'ray-x/lsp_signature.nvim'

    -- Snippets plugin
    use {
        'L3MON4D3/LuaSnip',
        requires = {'rafamadriz/friendly-snippets'}, -- Snippets collection
        config = require('plugins.luasnip')
    }

    -- vim api documentation for lua lsp
    use {'ii14/emmylua-nvim'}

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-buffer'}, -- Buffer source
            {'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim'}, -- Git source
            {'hrsh7th/cmp-nvim-lsp'}, -- LSP source
            {'hrsh7th/cmp-nvim-lua'}, -- Neovim Lua API documentation source
            {'hrsh7th/cmp-path'}, -- Path source
            {'saadparwaiz1/cmp_luasnip'} -- Snippets source
        },
        config = require('plugins.cmp')
    }

    -- Automatic brackets
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end,
        config = require('plugins.treesitter')
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

    -- Markdown preview
    use({
        'iamcco/markdown-preview.nvim',
        run = 'cd app && npm install',
        setup = function() vim.g.mkdp_filetypes = {'markdown'} end,
        ft = {'markdown'}
    })

    -- Edit GPG encrypted files transparently
    use 'jamessan/vim-gnupg'

    -- High performance color highlighter
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end
    }

    -- If Packer was just installed,
    -- sync plugins
    if Packer_bootstrap then require('packer').sync() end

end)

-- Sync plugins if Packer was just
-- installed
if Packer_bootstrap then
    print('Syncing plugins')
    require('packer').sync()
end
