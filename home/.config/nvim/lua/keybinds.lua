vim.keymap.set("n", "<leader>b", function()
  local current_theme = vim.fn.eval("&background")
  if current_theme == "dark" then
    vim.cmd("set background=light")
  else
    vim.cmd("set background=dark")
  end
end, { desc = "Toggle background between dark and light" })

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Turn off search highlight" })
vim.keymap.set("n", "<leader>co", '<cmd>silent! execute "%bd|e#|bd#"<cr>', { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>a", "<cmd>e#<cr>", { desc = "Edit alternate file" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode with esc" })
