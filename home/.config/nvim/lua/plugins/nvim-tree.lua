-- Tree explorer
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
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- Open/close with alt-o
    vim.keymap.set("n", "<M-o>", vim.cmd.NvimTreeToggle)
  end,
}
