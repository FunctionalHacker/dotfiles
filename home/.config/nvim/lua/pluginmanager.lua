local fn = vim.fn
local cmd = vim.cmd

-- Install packer if it's not yet installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local packer_not_installed = fn.empty(fn.glob(install_path))

if packer_not_installed > 0 then
    print('Packer is not installed, cloning it now...')
    cmd('silent !git clone https://github.com/wbthomason/packer.nvim ' ..
            install_path)
end

-- Configure packer
cmd 'packadd packer.nvim'
local use = require('packer').use
require('packer').startup(function()

    -- The plugin manager itself
    use {'wbthomason/packer.nvim', opt = true}

    -- Colorscheme
    use 'monsonjeremy/onedark.nvim'

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
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Indent characters
    --use "lukas-reineke/indent-blankline.nvim"

    -- Tree explorer
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- Do stuff as sudo
    use 'lambdalisue/suda.vim'

    -- Read editorconfig settings
    use 'editorconfig/editorconfig-vim'

    -- Configs for built-in LSP
    use 'neovim/nvim-lspconfig'

    -- Install LSP executables
    use 'kabouzeid/nvim-lspinstall'

    -- Extensions for eclipse.jdt.ls
    use 'mfussenegger/nvim-jdtls'

    -- Completion framework
    use 'nvim-lua/completion-nvim'

    -- treesitter syntax highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate'
    }

    -- Syntax highlighting for languages
    -- that are not supported by treesitter
    use 'sheerun/vim-polyglot'

    -- Formatter plugin
    use 'sbdchd/neoformat'

    -- Make editing passwords safer
    use {
        'https://git.zx2c4.com/password-store',
        rtp = 'contrib/vim/redact_pass.vim'
    }

end)

-- Install plugins if packer was not installed
if packer_not_installed > 0 then cmd 'PackerInstall' end
