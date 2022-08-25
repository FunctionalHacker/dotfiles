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
        'catppuccin/nvim',
        as = 'catppuccin',
        config = require('plugins.colorscheme')
    }

	-- Startup screen/dashboard
	use 'glepnir/dashboard-nvim'

    -- Git in signcolumn
    use 'airblade/vim-gitgutter'

    -- Statusline
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup {options = {theme = 'catppuccin'}}
        end
    }

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
            {'nvim-telescope/telescope-ui-select.nvim'} -- Replace vim built in select with telescope
        }
    }

    -- Do stuff as sudo
    use 'lambdalisue/suda.vim'

    -- Display possible keybinds
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {spelling = {enabled = true}}
        end
    }

    -- Read editorconfig settings
    use 'editorconfig/editorconfig-vim'

    -- Install LSP server executables
    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup {} end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {automatic_installation = true}
        end
    }

    -- Configs for built-in LSP
    use {'neovim/nvim-lspconfig', config = require('plugins.lspconfig').setup}

    -- Additional LSP features for Java
    use 'mfussenegger/nvim-jdtls'

    -- Display function signature
    use 'ray-x/lsp_signature.nvim'

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'}, -- LSP source
            {'hrsh7th/cmp-path'}, -- Path source
            {'petertriho/cmp-git', requires = "nvim-lua/plenary.nvim"}, -- Git source
            {'hrsh7th/cmp-buffer'}, -- Buffer source
            {'saadparwaiz1/cmp_luasnip'}, -- Snippets source
            {'L3MON4D3/LuaSnip'}, -- Snippets plugin
            {'rafamadriz/friendly-snippets'} -- Snippets collection
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

	-- If Packer was just installed,
	-- sync plugins
	if Packer_bootstrap then
		require('packer').sync()
	end

end)

-- Sync plugins if Packer was just
-- installed
if Packer_installed then
    print('Syncing plugins')
    require('packer').sync()
end
