-- Install lazy if it's not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy
local plugins = {
  -- Colorscheme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = true,
  },

  -- Git status in signcolumn
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },

  -- Tabline/bufferline
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = true,
  },

  -- Git commands
  "tpope/vim-fugitive",

  -- Indent characters
  {
    "lukas-reineke/indent-blankline.nvim",
    config = require("plugins.indent-blankline"),
  },

  -- Tree explorer
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugins.nvim-tree"),
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = require("plugins.telescope"),
    dependencies = {
      "nvim-lua/plenary.nvim", -- Internal dep for telescope
      -- Use fzf for fuzzy finder
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-ui-select.nvim", -- Replace vim built in select with telescope
      "zane-/cder.nvim", -- cd plugin for telescope
    },
  },

  -- Do stuff as sudo
  "lambdalisue/suda.vim",

  -- Display possible keybinds
  { "folke/which-key.nvim", config = require("plugins.which-key") },

  -- Package manager for LSP servers, DAP adapters etc.
  {
    "williamboman/mason.nvim",
    config = require("plugins.mason").setup,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },

  -- Additional LSP features for Java
  "mfussenegger/nvim-jdtls",

  -- DAP plugin
  { "mfussenegger/nvim-dap", config = require("plugins.dap") },

  -- Display function signature
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = { always_trigger = true },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
    end,
  },

  -- Snippets plugin
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets collection
    config = require("plugins.luasnip"),
  },

  -- vim api documentation for lua lsp
  "ii14/emmylua-nvim",

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer", -- Buffer source
      { "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" } }, -- Git source
      "hrsh7th/cmp-nvim-lsp", -- LSP source
      "hrsh7th/cmp-nvim-lua", -- Neovim Lua API documentation source
      "hrsh7th/cmp-path", -- Path source
      "hrsh7th/cmp-cmdline", -- cmdline source
      "saadparwaiz1/cmp_luasnip", -- Snippets source
      "f3fora/cmp-spell", -- Spell check source
    },
    config = require("plugins.cmp"),
  },

  -- Automatic brackets
  {
    "windwp/nvim-autopairs",
    config = true,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = require("plugins.treesitter"),
  },

  -- treesitter plugin for commentstring
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- mappings for commenting in code
  "tpope/vim-commentary",

  -- we all know this one
  "tpope/vim-surround",

  -- Formatter plugin
  "sbdchd/neoformat",

  -- Make editing passwords safer
  {
    "https://git.zx2c4.com/password-store",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "contrib/vim/redact_pass.vim")
    end,
  },

  -- Neovim inside Firefox
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },

  -- Vim <3 Asciidoctor
  "habamax/vim-asciidoctor",

  -- Asciidoc preview
  { "tigion/nvim-asciidoc-preview", ft = { "asciidoctor" } },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Edit GPG encrypted files transparently
  "jamessan/vim-gnupg",

  -- High performance color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },

  -- Caddyfile syntax support
  "isobit/vim-caddyfile",

  -- Startup dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = require("plugins.dashboard"),
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
  },

  -- Better folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = require("plugins.ufo"),
  },

  -- GitHub Copilot
  { "zbirenbaum/copilot.lua", config = true },
}

local lazy_opts = {}

require("lazy").setup(plugins, lazy_opts)
