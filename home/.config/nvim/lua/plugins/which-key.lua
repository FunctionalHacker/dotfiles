-- Display possible keybinds
-- Plugin specific keybinds are set up in plugin configuration file
return {
  "folke/which-key.nvim",
  config = function()
    local wk = require("which-key")
    wk.setup({})

    wk.register({
      h = { "<cmd>nohlsearch<CR>", "Turn off search highlight" },
    }, { prefix = "<leader>" })

    wk.register({
      ["<C-n>"] = { "<cmd>bnext<CR>", "Next buffer" },
      ["<C-b>"] = { "<cmd>bprevious<CR>", "Previous buffer" },
    })

    -- Open cder
    wk.register({ cd = {
      function()
        vim.cmd("Telescope cder")
      end,
      "Change directories",
    } })

    -- Exit terminal insert mode with esc
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})
  end,
}
