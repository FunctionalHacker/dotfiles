-- Display possible keybinds
-- Here I have also defined some generic keybinds
-- Plugin specific keybinds are set up in plugin configuration file
--- @type LazyPluginSpec
return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup()

    wk.register({
      h = { "<cmd>nohlsearch<cr>", "Turn off search highlight" },
    }, { prefix = "<leader>" })

    wk.register({
      ["<C-n>"] = { "<cmd>bnext<cr>", "Next buffer" },
      ["<C-b>"] = { "<cmd>bprevious<cr>", "Previous buffer" },
    })

    -- Exit terminal insert mode with esc
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})
  end,
}
