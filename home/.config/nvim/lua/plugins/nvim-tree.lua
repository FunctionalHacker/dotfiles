-- Tree explorer
--- @type LazyPluginSpec
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    renderer = {
      highlight_git = true,
    },
    update_focused_file = {
      enable = true,
    },
  },
  keys = {
    {
      desc = "Open/close nvim-tree",
      "<leader>o",
      "<cmd>NvimTreeToggle<cr>",
    },
  },
}
