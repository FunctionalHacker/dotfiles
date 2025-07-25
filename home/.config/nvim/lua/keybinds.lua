local k = vim.keymap.set

k("n", "<leader>b", function()
  local current_theme = vim.fn.eval("&background")
  if current_theme == "dark" then
    vim.cmd("set background=light")
  else
    vim.cmd("set background=dark")
  end
end, { desc = "Toggle background between dark and light" })

k("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Turn off search highlight" })
k("n", "<leader>co", '<cmd>silent! execute "%bd|e#|bd#"<cr>', { desc = "Close other buffers" })
k("n", "<leader>a", "<cmd>e#<cr>", { desc = "Edit alternate file" })
k("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
k("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
