return function()
  local wk = require("which-key")
  local gitsigns = require("gitsigns")
  wk.setup({})

  wk.register({
    f = { "<cmd>Neoformat<CR>", "Format with Neoformat" },
    h = { "<cmd>nohlsearch<CR>", "Turn off search highlight" },
  }, { prefix = "<leader>" })

  wk.register({
    ["<C-n>"] = { "<cmd>bnext<CR>", "Next buffer" },
    ["<C-b>"] = { "<cmd>bprevious<CR>", "Previous buffer" },
    ["["] = { h = { gitsigns.prev_hunk, "Previous hunk" } },
    ["]"] = { h = { gitsigns.next_hunk, "Next hunk" } },
  })

  -- Exit terminal insert mode with esc
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {})
end
