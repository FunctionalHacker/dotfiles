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
    config = require("plugins.colorscheme"),
  },

  -- Replace much of neovim's default UI
  -- with a modern replacement
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = require("plugins.noice"),
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugins.lualine"),
  },

  -- Tabline/bufferline
  { "akinsho/bufferline.nvim", version = "v3.*", dependencies = { "kyazdani42/nvim-web-devicons" }, config = true },

  -- Git status in signcolumn
  { "lewis6991/gitsigns.nvim", config = true },

  -- Git commands
  "tpope/vim-fugitive",

  -- Indent characters
  { "lukas-reineke/indent-blankline.nvim", config = require("plugins.indent-blankline") },

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
      -- Internal dependency for telescope
      "nvim-lua/plenary.nvim",

      -- Use fzf for fuzzy finder
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      -- Replace vim built in select with telescope
      "nvim-telescope/telescope-ui-select.nvim",

      -- cd plugin for telescope
      "zane-/cder.nvim",
    },
  },

  -- Do stuff as sudo
  "lambdalisue/suda.vim",

  -- Display possible keybinds
  { "folke/which-key.nvim", config = require("plugins.which-key") },

  -- Package manager for LSP servers, DAP adapters etc.
  {
    "williamboman/mason.nvim",
    config = require("plugins.lsp").setup,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },

  -- Additional LSP features for Java
  "mfussenegger/nvim-jdtls",

  -- Show code LSP context in winbar
  { "SmiteshP/nvim-navic", config = true, opts = { mouse = true } },

  -- DAP plugin
  { "mfussenegger/nvim-dap", config = require("plugins.dap") },

  -- Snippets plugin
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets collection
    config = require("plugins.luasnip"),
  },

  -- vim api documentation for lua lsp
  { "ii14/emmylua-nvim", ft = { "lua" } },

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
      "zbirenbaum/copilot-cmp", -- Copilot source
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
    config = function()
      vim.g.firenvim_config = {
        localSettings = {
          [".*"] = {
            takeOver = "never",
          },
        },
      }
    end,
  },

  -- Vim ♥️ Asciidoctor
  { "habamax/vim-asciidoctor", ft = { "asciidoctor", "asciidoc" } },

  -- Asciidoc preview
  { "tigion/nvim-asciidoc-preview", ft = { "asciidoctor", "asciidoc" } },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Edit GPG encrypted files transparently
  { "jamessan/vim-gnupg", ft = { "gpg" } },

  -- High performance color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },

  -- Caddyfile syntax support
  { "isobit/vim-caddyfile", ft = "caddyfile" },

  -- Startup dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = require("plugins.dashboard"),
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
  },

  -- Better folds
  {
    enabled = false,
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = require("plugins.ufo"),
  },

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
}

require("lazy").setup(plugins, { lockfile = "~/git/dotfiles/home/.config/nvim/lazy-lock.json" })
